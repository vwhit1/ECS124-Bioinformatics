# Write a program, using tr, to complement (A-T, C-G) any DNA sequence

$nucstring = 'acCtagGgCCTTAcga';
$nucstring =~ tr/A-Z/a-z/; # make them all the same case
$nucstring =~ tr/tg/AC/; # do half of the complements, switch case so they're not affected by the next line
$nucstring =~ tr/ac/TG/; # do the other half of them, lowercase = hasn't been complemented yet

print $nucstring;