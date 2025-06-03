#!/pkg/bin/perl -w
#This is the Needleman-Wunsch global alignment algorithm without gaps 
#in the model and
#with match value given by user, and mismatch and indel value given by user.
#It also has separate gap opening and gap extension penalties.
#dg
open (OUT, '> outer2');         #Open a file called 'outer2' for outputing.
print "Input string 1 \n";
$line = <>;
chomp $line;
@string1 =  split(//, $line);  #split up the line into individual characters
                               #and place the characters into a list, whose
                               #first index is 0 (here Perl has inherited
                               #one of the worst features of C) See Johnson
                               # 4.3 for an introduction to lists.  Look up
                               # split in the index and read it.

print "Input string 2 \n";
$line = <>;
chomp $line;
@string2 =  split(//, $line);

# Exercise 1: Assigning costs

print "Input Match Value (positive number)\n";
$Mv = <>; # not caling it V because that's what the matrix is called
print "Input Mismatch Cost (negative number)\n";
$Cm = <>;
print "Input Gap Opening Cost (negative number)\n";
$Go = <>;
print "Input Gap Extension Cost (negative number)\n";
$Ge = <>;


# Back to original code

$n = @string1;                 #assigning a list to a scalar just assigns the
                               #number of elements in the list to the scalar.
$m = @string2;

print "The lengths of the two strings are $n, $m \n";   # Just to make sure this works.

$V[0][0] = 0;                  # Assign the 0,0 entry of the V matrix


# Initialization is also different because the top row is essentially
# the biggest gap extension

for ($i = 1; $i <= $n; $i++) {
   if ($i == 1) {
     $V[$i][0] = $Go; # First entry has gap open cost
     print OUT "$string1[$i-1]";
   } else {
     # After first init. entry, it's gap extension, because it's more and more spaces 
     $V[$i][0] = $V[$i-1][0] + $Ge;
     print OUT "$string1[$i-1]";
   }
}
   print OUT "\n\n"; # newlines between the strings so we can tell the difference when debugging

for ($j = 1; $j <= $m; $j++) { # Assign the row 0 values and print String 2
   if ($j == 1) {
       $V[0][$j] = $Go;
       print OUT "$string2[$j-1]";
   } else {
       $V[0][$j] = $V[0][$j-1] + $Ge;
       print OUT "$string2[$j-1]";
   }
}
   print OUT "\n\n"; # Added this to give space between string2 and the recurrences



%gap_positions = ();


for ($i = 1; $i <= $n; $i++) {      # follow the recurrences to fill in the V matrix.
 for ($j = 1; $j <= $m; $j++) {
   print OUT "$string1[$i-1], $string2[$j-1]\n"; # This is here  for debugging purposes.
   if ($string1[$i-1] eq $string2[$j-1]) {
     # print OUT "Match\n";
     $t = $Mv; } # Assigning it the match cost
   else {
     # print OUT "Mismatch - Let's check against Space\n";
     $t = $Cm; # Assigning it the mismatch cost
   }

  $max = $V[$i-1][$j-1] + $t;  
# Handle horizontal gaps (in sequence 2)
    # First checks the hash for whether the previous position has a gap opened.
    # If it does, we add the gap open cost and log this position as having a gap opened.
    # If it doesn't, we add the gap extension cost.
    if (!exists $gap_positions{"$i,$j-1"}) {  # No existing gap
      if ($V[$i][$j-1] + $Go > $max) {
        # print OUT "Gap opened here.\n";
        $max = $V[$i][$j-1] + $Go;
        $gap_positions{"$i,$j-1"} = 1;  # Store gap position
      }
    } else {  # Existing horizontal gap
      if ($V[$i][$j-1] + $Ge > $max) {
        # print OUT "Gap extended here.\n";
        $max = $V[$i][$j-1] + $Ge;
      }
    }

    # Handle vertical gaps (in sequence 1)
    # Same logic as above.
    if (!exists $gap_positions{"$i-1,$j"}) {  # No existing vertical gap
      if ($V[$i-1][$j] + $Go > $max) {
        # print OUT "Gap opened here.\n";
        $max = $V[$i-1][$j] + $Go;
        $gap_positions{"$i-1,$j"} = 1;  # Store gap position
      }
    } else {  # Existing vertical gap
      if ($V[$i-1][$j] + $Ge > $max) {
        # print OUT "Gap extended here.\n";
        $max = $V[$i-1][$j] + $Ge;
      }
    }

    $V[$i][$j] = $max;
    print OUT "V[$i][$j] has value $V[$i][$j]\n";
  }
}

print OUT "\n The similarity value of the two strings is $V[$n][$m]\n";

close(OUT);
