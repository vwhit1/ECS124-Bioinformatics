print "Testing if a string contains a substring that matches the RNA pol II promoter sequence.\n";
$varstring = "TATATATACTGTCACTGCTAGCTATTCAGG";
if ($varstring =~ m/TATA[AT]A[AT][ATCG]{17}[CT]{2}CA[AG]{2}/){ print "YES\n"; }