# Try out the above code, using file names and data that you create.

print "Please input the name of a file to be read.\n";
$infile = <>;
open IN, "$infile";
print "Please input the name of the file to print to.\n";
$outfile = <>;
open OUT, ">$outfile";
open OUT1, '>myoutputfile';
$line = <IN>;
$line =~ tr/ATCG/X/;
print OUT "$line";
print OUT1 "$line";
close(IN);
close(OUT);
close(OUT1);

# Then change the double quotes to single quotes in the statement open OUT
# and rerun the program. Explain the result.

print "Please input the name of a file to be read.\n";
$infile = <>;
open IN, "$infile";
print "Please input the name of the file to print to.\n";
$outfile = <>;
open OUT, '>$outfile';
open OUT1, '>myoutputfile';
$line = <IN>;
$line =~ tr/ATCG/X/;
print OUT "$line";
print OUT1 "$line";
close(IN);
close(OUT);
close(OUT1);

# No file is exported because the string is not interpolated because of the single quotes.


# Next change the single quotes to double quotes in the statement open OUT1,
# rerun and explain the results.

print "Please input the name of a file to be read.\n";
$infile = <>;
open IN, "$infile";
print "Please input the name of the file to print to.\n";
$outfile = <>;
open OUT, ">$outfile";
open OUT1, ">myoutputfile";
$line = <IN>;
$line =~ tr/ATCG/X/;
print OUT "$line";
print OUT1 "$line";
close(IN);
close(OUT);
close(OUT1);

# The output to the user-inputted outfile is the same as the first one because 
# 1) there is no "myoutputfile" named with a specific file name and 2) 
# even if there was, there is no $ in front so it isn't called even with the double quotes.
# The outfile has the top line of the infile written to it,
# and a new file called "myoutputfile" is created
# that also has the top line of the infile written to it.