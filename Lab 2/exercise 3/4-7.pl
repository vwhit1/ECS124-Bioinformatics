print "Input a sequence to see if it matches the restriction enzyme recognition sequence GCCNNNNNGGC.";
$seq = <>;
if ($seq =~ m/GCC[ATCG]{5}GGC/){ print "YES\n"; } else {print "No\n";}