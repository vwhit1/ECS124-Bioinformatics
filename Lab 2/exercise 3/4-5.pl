=begin
Explain what s/(CA){5}(CA)*/X/g; does.
Unfortunately it does not replace all CACACACACA with XXXXX
=cut

print("Input repeating CA sequence to try to turn them into X. Input 'stop' to stop.");
$seq = <>;
$seq =~ s/(CA){5}(CA)*/X/g;
print $seq;

# Oh, it replaces any number of repeats of CA as long as it's greater than 5 with a single X.