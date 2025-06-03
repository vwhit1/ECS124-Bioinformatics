#!/pkg/bin/perl -w
use diagnostics;  # this will generate more complete explanations of any errors
#
#program kmer4.pl
#This program expands on kmer2.pl which expands on kmer1.pl which expands
#on kmer.pl.
# This program finds all the overlapping k-mers of the input string. It builds
# an associative array where each key is one distinct k-mer in the string,
# and the associated value is a list of starting positions where that
#k-mer is found. For example, if the input is ACACTCA and k is 2, then
#one key is AC with a list of 1,3; another key is CA with a list of 2,6;
#another key is CT with a list of 4; and one key is TC with a list of 5.
#
#Note the use of derefrencing in order to build up each array in
#the hash of arrays, and its use again to join the array into a string for
#printing a comma seperated list.
#dg

print "Input the string\n";
$dna = <>;
chomp $dna;
print "Input the length of the window\n"; 
$k = <>;
chomp $k;

# %kmer = ();
$i = 1;
while (length($dna) >= $k) {
  $dna =~ m/(.{$k})/; 
  print "$1, $i \n";
   if (!defined $kmer{$1}) {
    $kmer{$1} = [$i];    # here we tell Perl that the value of a kmer entry will
                         # be an array. This is done by enclosing $i with [ ].
                         # More correctly, $kmer{$1} is a reference to an array
                         # whose first value is the value of $i.
   }
 else { push (@{$kmer{$1}}, $i)}  # here we expand the array associated with key
                                  # value $1 by adding another
                                  # element to the array.  We first have to dereference
                                  # the reference $kmer{$1} which is done by enclosing
                                  # it with curly brackets.

  $i++;
  $dna = substr($dna, 1, length($dna) -1);
}

foreach $kmerkey (sort keys(%kmer)) {
 $occrs = join(', ' , @{$kmer{$kmerkey}});
 print "The occurrences of string $kmerkey are in positions $occrs \n";
}
