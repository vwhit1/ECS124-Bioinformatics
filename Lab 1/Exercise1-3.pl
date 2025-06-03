# Modify the above program to print the RNA string
# above the DNA string.

$nucstring = 'acCtagGgCCTTAcga';
$nucstring =~ tr/tT/uU/;
print "$nucstring \n";
$nucstring =~ tr/uU/tT/;
print "$nucstring \n";