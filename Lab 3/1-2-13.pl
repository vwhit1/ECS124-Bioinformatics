print "Enter the DNA sequence:\n";
$varstring = <STDIN>;

# Single regex for both: m/(TTGACA[ATCG]{18}TATATT)|(TTTACA[ATCG]{18}TATGTT)/

if ($varstring =~ m/(TTGACA[ATCG]{18}TATATT)/){ print "YES, consensus promoter sequence\n"; }
elsif ($varstring =~ m/(TTTACA[ATCG]{18}TATGTT)/){ print "YES, lactose promoter sequence\n"; }
else {print "NO promoter sequence.\n";}

# Unfortunately we can't just make an "or" in the first and second boxes 
# because that would allow sequences that start with the consensus box 
# and end with the lactose box