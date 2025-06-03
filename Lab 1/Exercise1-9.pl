# Using tr, write a program to count the number
# of purines in a DNA sequence, without changing the sequence

$nucstring = 'acCtagGgCCTTAcga';
$nucstring =~ tr/A-Z/a-z/; # make them all the same case
$count = $nucstring =~ tr/ag/X/; # the tr function returns the number of swaps made
print "There are $count purines.";