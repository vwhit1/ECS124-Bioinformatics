#Convert fastq to fasta

print "Please input the name of a fasta file for conversion.\n";
$fasta = <>;
open IN, "$fasta";
print "Please input the name of the fastq file to print to.\n";
$fastq = <>;
open OUT, ">$fastq";

while ($line = <IN>) {
    $line =~ tr/>/@/; # change > to @
    print OUT "$line"; # write that out
    $line =~ tr/@/+/; # save line name to repeat for quality score 
    $repeatname = $line; # save it

    $line = <IN>; # next line: the sequence
    print OUT "$line"; # print next line as is
    $line =~ tr/A-Z/B/; # make fake score that is the same chracter length as the seq
    $fakescore = $line; # save it

    # Now for the quality
    print OUT "$repeatname"; # quality score name title made above
    print OUT "$fakescore"; # fake score made above
}

close(IN);
close(OUT);