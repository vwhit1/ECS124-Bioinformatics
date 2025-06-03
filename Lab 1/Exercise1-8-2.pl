# Write another program that translates a DNA string
# into the RNA string that would be transcribed from it.
# Ignore 5'-3' orientation.

$nucstring = 'acCtagGgCCTTAcga';
$nucstring =~ tr/A-Z/a-z/; # I assume we want it in the same case
$nucstring =~ tr/t/u/; # Changes thymine to uracil
print "$nucstring \n";