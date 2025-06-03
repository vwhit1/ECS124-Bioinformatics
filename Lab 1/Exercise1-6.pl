# Divide an amino acid sequence into Ambivalent, External, and Internal structure groups.

$aminoacidseq = 'SEETQMRLQLKRKLQRNRTSFTQEQIEALEKEFERTHYPDVFARERL';

$aminoacidseq =~ tr/ACGPSTWY/A/; # replace ambivalent amino acids with A
$aminoacidseq =~ tr/RNDQEHK/E/; # replace external amino acids with E
$aminoacidseq =~ tr/ILMFV/I/; # replace internal amino acids with I

print $aminoacidseq;