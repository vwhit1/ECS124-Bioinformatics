# Write the complete program to read in a file name, open the file,
# read and process two lines from the file as above.
# Don't use the file name $filename, and don't use the filehandle IN.

print "Please input the name of a file to be read.\n";
$filetoread = <>; # asks user for file name
open infile, "$filetoread"; # interpolates file name given
$_ = <infile>;
chomp; # remove newline
print; # print first line
chomp; # remove newline
print; # print second line
close (infile)