=begin
Modify the regular expression presented in the discussion
of Rule 5, such that the new regular expression matches all of 
TATATAGG, and not only TAGG.

Rule 5 (repetition): * means repeat the closest preceding regex 
zero or more times, + means repeat the closest preceding regex 
ONE or more times
=cut

print "Testing if TATATAGG contains a substring that matches (TA)+GG.\n";
$varstring = "TATATAGG";
if ($varstring =~ m/(TA)+GG/){ print "YES\n"; }
print "Adding parentheses means the regex checks if TA is repeated not just A\n\n";