#!/pkg/bin/perl -w
use diagnostics;  # this will generate more complete explanations of any errors
#

# Step 1: Read the query sequence from a file instead of user input
print "Reading query sequence from text file:\n";
#open(Q, "query.txt");  # Open query file. 
# ^ I pasted the query line from perlblastdata.txt into a file and named it query.txt 

$dna = <Q>;  # Read the query sequence

#$dna = "AGTAGTATGTAGATA";

chomp $dna;
#print $dna; #(debugging) 
close(Q);  # Close query file


# We will test with k-mer sizes 3 and 4, and thresholds 6 and 7
print("What k-mer threshold do you want?\n");
$k = <>;
chomp $k;
print("What HSP threshold do you want?\n");
$t = <>;
chomp $t;

%kmer = ();  # Hash to store first occurrence of each k-mer
$i = 1;  # Initialize position counter

# Step 2: Extract k-mers from query sequence and store all occurrences
while (length($dna) >= $k) {
  $dna =~ m/(.{$k})/; 
  print "$1, $i \n"; # it was giving me an error to keep it up there
   if (!defined $kmer{$1}) { # check if kmer is in the hash already or not
    $kmer{$1} = [$i];    # here we tell Perl that the value of a kmer entry will
                         # be an array. This is done by enclosing $i with [ ].
                         # More correctly, $kmer{$1} is a reference to an array
                         # whose first value is the value of $i.
   }
 else { push (@{$kmer{$1}}, $i)}  # here we expand the array associated with key
                                  # value $1 by adding another
                                  # element to the array.  We first have to dereference
                                  # the reference $kmer{$1} which is done by enclosing
                                  # it with curly brackets.

    #print "$1, $i \n"; # it was giving me an error to keep it up there
  $i++;
  $dna = substr($dna, 1, length($dna) -1); # Remove first character for overlapping k-mers
}


# The cool part begins 
# Read one sequence at a time from perlblastdata.txt and scan its k-mers
open(DB, "perlblastdata.txt"); # I modified this to only have the 5 "database" sequences


#open(DB, "debugperlblastdata.txt"); # a debug version


#$/ = "";  # $/ is input record separator, so when it's \n as default
# it reads the file line by line. When it's "" it reads it by paragraph
# I'm a little confused by why we want to have this when the toy GenBank
# separates sequences by newlines not paragraphs and each sequence is only a line,
# but hey it's in the requirements to explain it so



while ($seq = <DB>) {  # Read each paragraph (sequence)
    chomp $seq;
    print "$seq\n";
    $j = 0;  # Position counter (I actually like zero based indexing sorry Dr. Frid)
    %stringhash = ();  # Hash to prevent duplicate reporting

    # Next scan through database sequence k-mers
    while ($j <= length($seq) - $k) {
        $sub = substr($seq, $j, $k);  # Extract 4-mer from database sequence
        print "$sub\n";

        # Check if the k-mer exists in the query sequence
        if (defined $kmer{$sub}) {
            foreach $pos (@{$kmer{$sub}}) {  # Iterate through all query positions
                $left = $pos;  # Initialize left boundary in query
                $right = $pos + $k;  # Initialize right boundary in query
                $left_db = $j;  # Initialize left boundary in database sequence
                $right_db = $j + $k;  # Initialize right boundary in database sequence

                print "Initial Left for query kmer: $left\n";
                print "Initial Right for query kmer: $right\n";
                print "Initial Left for database kmer: $left_db\n";
                print "Initial Right for database kmer: $right_db\n";


                # Extend match to the left
                # It's an ugly condtional but I was getting errors for out of bounds without it
                while ($left - 1 < length($dna) && $left_db - 1 < length($seq) && substr($dna, $left-1, 1) eq substr($seq, $left_db-1, 1)) {
                    $left--;
                    $left_db--;
                }

                # Extend match to the right
                while ($right < length($dna) && $right_db < length($seq) && substr($dna, $right, 1) eq substr($seq, $right_db, 1)) {
                    $right++;
                    $right_db++;
                }

                # Calculate length of extended match
                $match_length = $right - $left;
                print "Right: $right\n";
                print "Left: $left\n";
                print "Match length: $match_length\n";

                # Check if match is long enough and prevent duplicate reports
                if ($match_length > $t && !defined $stringhash{$left_db}) {
                    $stringhash{$left_db} = 1;  # Mark position as reported
                    print "HSP found: $match_length characters match in database at $left_db\n";
                }
            }
        }
        $j++;  # Move to next k-mer position in database sequence
    }
}

if (!keys %stringhash) { # check if nothing got saved to stringhash at all
    print "No HSPs were found.\n";
}

close(DB);



=begin
For keeping track...

Your program should do the following things:

⦁ Read in from a file a query string Q.

⦁ For k = 4, use program kmerfirst.pl to find the first location of each different k-mer in Q.

⦁ Successively read in one string at a time from a file called perlblastdata.txt . 
When a string S is read in, scan through its 4-mers, using the same hash as before. 
For this, extract and adapt what you need from kmerfirst.pl.

⦁ Whenever a 4-mer in S is determined to be in Q, extract the location of the first occurrence of
that 4-mer in Q. 
Then put the characters of Q and S in arrays (as we did in needleman.pl) so
that you can examine individual characters. 
Then scan left from the k-mer in Q and in S, as long
as you find matching characters. 
Repeat to the right. Let L denote the length of the whole match
obtained in this way. 
If L is greater than 10, then print a message that a good HSP has been
found between Q and S, and print S. 

Notice that the same HSP gets reported multiple times.
Explain why that happens.

⦁ Now we will alter the code so that HSP are not reported multiple times. We can do it using a
hash called stringhash: Whenever PERL-BLAST finds a reportable substring in a database,
starting at position $i (e.g. in the database string), it searches whether $stringhash{$i} is
defined. If it is, it does not report the string again. 
Otherwise it assigns the string to $stringhash{$i} and reports the string.

⦁ We would like to process strings that are more than a single line long. So in the file each string
will be held in consecutive lines, with strings separated by blank lines. That is analogous to each
string being a paragraph instead of just a single line.
To read in a paragraph, put the line $/ = ""; somewhere in the program before the string is read.
What does this line do ?

⦁ Finally, we will make it so that if a k-mer that is present in the database string is also in the
query string in multiple locations, then a search should be made from each occurrence of the
k-mer in the query string, spanning outward left and right of each occurrence. To do that use
kmer4.pl to build up a list of all occurrences of each distinct k-mer in the query string, and use it
to implement this change.

Congratulations, you made your own version of BLAST!


Regarding what to hand-in:
for each step, provide the changes in the code that you implemented and a test case, 
where you show the desirable result. As a test case, use the file perlblastdata.txt. 

Your program should ask for a threshold t, and report each string in the database that has one or more substrings matching 
any substring in the query that has a length at least t. 
Also report the actual length of the longest matching substring. Report the results for k=3 and k=4 when
threshold t=6 and t=7 (4 combinations total).
=cut