=begin
Write a regex that matches this RNA pol II promoter sequence:
TATAWAW (W is A or T), 17 nucleotides, then YYCARR (Y is C or T, R is A or G)
=cut

print "Input a sequence to see if it matches an RNA pol II promoter sequence.";
$seq = <>;
if ($seq =~ m/TATA[TA]A[TA][ATCG]{17}[CT]{2}A[AG]{2}/){ print "YES\n"; } else {print "No\n";}