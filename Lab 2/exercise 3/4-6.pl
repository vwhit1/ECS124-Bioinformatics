=begin
(\s\w\d{5}\s|\s\w{2}\d{6}\s) is a regex that matches Genbank accession numbers.
Would (\s\w{1,2}\d{5,6}\s) work?
=cut

print '(\s\w{1,2}\d{5,6}\s) would not work for Genbank accession numbers because it would match one letter followed by six digits or two letters followed by five digits also.';
print "\nTesting with GA16523 to check:\n";

$genbankid = " GA16523 ";
if ($genbankid =~ m/(\s\w{1,2}\d{5,6}\s)/){ print "YES, GA16523 matches this regex despite not being a valid Genbank ID.\n"; } else {print "No\n";}