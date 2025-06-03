# This program reads in one string and then uses the tr function to
# count and replace all the uppercase characters with the
# character X.

print "Enter a DNA string where the case matters, and hit return\n";
$text = <STDIN>; # STanDard INput (keyboard input)
#chomp $text; # Remove any ending new-line character from the input
# Commenting the above line out means there's an extra \n at the end.
print "The original sequence is $text\n";

$count = $text =~ tr/ATCG/X/; # Replaces all caps with X, and counts how many replacements
print "There are $count capital characters in the original sequence.
The sequence now is $text\n"
