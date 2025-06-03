#!/pkg/bin/perl -w
#This is the Needleman-Wunsch global alignment algorithm without gaps 
#in the model and
#with match value given by user, and mismatch and indel value given by user.
#dg
open (OUT, '> outer1');         #Open a file called 'outer1' for outputing.
print "Input string 1 \n";
$line = <>;
chomp $line;
@string1 =  split(//, $line);  #split up the line into individual characters
                               #and place the characters into a list, whose
                               #first index is 0 (here Perl has inherited
                               #one of the worst features of C) See Johnson
                               # 4.3 for an introduction to lists.  Look up
                               # split in the index and read it.

print "Input string 2 \n";
$line = <>;
chomp $line;
@string2 =  split(//, $line);

# Exercise 1: Assigning costs

print "Input Match Value (positive number)\n";
$Mv = <>; # not caling it V because that's what the matrix is called
print "Input Mismatch Cost (negative number)\n";
$Cm = <>;
print "Input Indel Cost (negative number)\n";
$Im = <>;


# Back to original code

$n = @string1;                 #assigning a list to a scalar just assigns the
                               #number of elements in the list to the scalar.
$m = @string2;

print "The lengths of the two strings are $n, $m \n";   # Just to make sure this works.

$V[0][0] = 0;                  # Assign the 0,0 entry of the V matrix

for ($i = 1; $i <= $n; $i++) { # Assign the column 0  values and print 
                               # String 1  See section 5.2 of Johnson
                               # for loops
   $V[$i][0] = -$i;
   print OUT "$string1[$i-1]";  # Note the -1 here because array indexes start at 0 (ug!)
}
   print OUT "\n\n";

for ($j = 1; $j <= $m; $j++) { # Assign the row 0 values and print String 2
   $V[0][$j] = -$j;
   print OUT "$string2[$j-1]";
}
   print OUT "\n\n"; # Added this to give space between string2 and the recurrences

for ($i = 1; $i <= $n; $i++) {      # follow the recurrences to fill in the V matrix.
 for ($j = 1; $j <= $m; $j++) {
#   print OUT "$string1[$i-1], $string2[$j-1]\n"; # This is here  for debugging purposes.
   if ($string1[$i-1] eq $string2[$j-1]) {
     $t = $Mv; } # Assigning it the match cost
   else {
   $t = $Cm; # Assigning it the mismatch cost
   }

  $max = $V[$i-1][$j-1] + $t;  
#  print OUT "For $i, $j, t is $t \n"; # Another debugging line.
  if ($max < $V[$i][$j-1] + $Im) {
    $max = $V[$i][$j-1] + $Im; # Assigning it the indel cost
  }

  if ($V[$i-1][$j] + $Im > $max) {
    $max = $V[$i-1][$j] + $Im; # Assigning it the indel cost
  }
  $V[$i][$j] = $max; 
 print OUT "V[$i][$j] has value $V[$i][$j]\n";
  }
}
print OUT "\n The similarity value of the two strings is $V[$n][$m]\n";

close(OUT);
