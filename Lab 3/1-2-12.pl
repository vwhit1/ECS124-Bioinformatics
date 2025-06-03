print "Testing if a string contains a substring that matches the E. Coli consensus promoter sequence.\n";
$varstring = "TTGACAACGTACGTTGCAACGTTGTATATT";
if ($varstring =~ m/TTGACA[ATCG]{18}TATATT/){ print "YES\n"; }