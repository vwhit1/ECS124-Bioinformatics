=begin
Write a full program to take in a string and then determine
if the string contains a substring that matches TA+GG.
Try the input ATATAAAGGGA; then try out the input ATATGGGA.

Then change the symbol + to * in the regular expression
and try out the two input strings again. Explain results.
=cut

print "Testing if ATATAAAGGGA contains a substring that matches TA+GG.\n";
$varstring = "ATATAAAGGGA";
if ($varstring =~ m/TA+GG/){ print "YES\n"; }
print "This is because it contains TAAAGG which matches the regex because the A is repeated\n\n";

print "Testing if ATATGGGA contains a substring that matches TA+GG.\n";
$varstring = "ATATGGGA";
if ($varstring =~ m/TA+GG/) {print "YES\n";} else {print "NO\n";}
print "This is because it contains TATGG which doesn't match the regex\n\n";

print "Changing the + to * means the A repetition is not required, so TGG is also valid.\n\n";
print "Testing if ATATGGGA contains a substring that matches TA*GG.\n";
if ($varstring =~ m/TA*GG/) {print "YES\n";} else {print "NO\n";}
print "This is because it contains TGG which matches the regex\n\n";
