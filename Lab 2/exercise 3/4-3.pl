=begin
According to the Prosite documentation, all known ER proteins,
except for liver esterases, contain one of the 24 strings defined by
the regular expression (K|R|H|Q|S|A)(D|E|N|Q)EL

The liver esterases are a bit different. Their motif is H followed by
one of {T,V,I} followed by EL.

Write a single Perl regex for that motif,
then write a single Perl regex for the "or " of the
two regex's for ER proteins,
then write a Perl program that takes in a sequence and checks to see 
if it contains any ER motif defined in this latter regex.

How many different ER motifs are defined by that regex?
=cut

print "Input a sequence to check if it contains an ER motif (normal or liver esterase)";
$sequence = <>;
if ($sequence =~ m/((K|R|H|Q|S|A)(D|E|N|Q)EL)|(H(T|V|I)EL)/){ print "YES\n"; } else {print "No\n";}

print "24 + 3 = 7 different ER motifs are defined by this regex";

# The textbook erroneously says that the regex for the 24 sequences is (K|R|H|Q|A)(D|E|N|Q)EL \n
# but it is actually (K|R|H|Q|S|A)(D|E|N|Q)EL because S (serine) is also allowed to start, as it says in the line above