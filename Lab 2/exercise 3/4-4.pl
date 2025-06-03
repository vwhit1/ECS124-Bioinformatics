=begin
Look up the triplets that code for serine and write a regex that matches the codons for serine.
Then write a regex that matches any codon for arginine or serine.
Don't do this via (serine regex)|(arginine regex)
=cut

print "Serine regex: TC[ATCG]|AG[TC]\n";
print "Arginine regex: CG[ATCG]|AG[AG]\n";
print "Serine OR Arginine regex: (TC|CG|AG)[ATCG]\n";
print "\nSerine OR Arginine test: input sequence ";
$sequence = <>;
if ($sequence =~ m/(TC|CG|AG)[ATCG]/){ print "YES\n"; } else {print "No\n";}