#Convert fastq to fasta

print "Please input the name of a fastq file for conversion.\n";
$fastq = <>;
open IN, "$fastq";
print "Please input the name of the fasta file to print to.\n";
$fasta = <>;
open OUT, ">$fasta";

while ($line = <IN>) {
    $line =~ tr/@/>/; # change @ to >
    print OUT "$line"; # write that out
    $line = <IN>;
    print OUT "$line"; # print next line as is
    # skip next two lines, these being the quality ones
    <IN>; # repeat of sequence name
    <IN>; # quality line
}

close(IN);
close(OUT);