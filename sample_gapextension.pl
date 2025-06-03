my $gap_opening = -2;
my $gap_extension = -1;

for ($i = 1; $i <= $n; $i++) {
   if ($i == 1) {
       $V[$i][0] = $gap_opening;
   } else {
       $V[$i][0] = $V[$i-1][0] + $gap_extension;
   }
}

for ($j = 1; $j <= $m; $j++) {
   if ($j == 1) {
       $V[0][$j] = $gap_opening;
   } else {
       $V[0][$j] = $V[0][$j-1] + $gap_extension;
   }
}

# Initialize a hash to keep track of gap positions
%gap_positions = ();

for ($i = 1; $i <= $n; $i++) {
  for ($j = 1; $j <= $m; $j++) {
    if ($string1[$i-1] eq $string2[$j-1]) {
      $t = $Mv; # Assigning it the match cost
    } else {
      $t = $Cm; # Assigning it the mismatch cost
    }

    $max = $V[$i-1][$j-1] + $t;  # Score for match or mismatch

    # Handle horizontal gaps (in sequence 2)
    if (!exists $gap_positions{"$i,$j-1"}) {  # No existing horizontal gap
      if ($V[$i][$j-1] + $gap_open > $max) {
        $max = $V[$i][$j-1] + $gap_open;
        $gap_positions{"$i,$j-1"} = 1;  # Store gap position
      }
    } else {  # Existing horizontal gap
      if ($V[$i][$j-1] + $gap_extend > $max) {
        $max = $V[$i][$j-1] + $gap_extend;
      }
    }

    # Handle vertical gaps (in sequence 1)
    if (!exists $gap_positions{"$i-1,$j"}) {  # No existing vertical gap
      if ($V[$i-1][$j] + $gap_open > $max) {
        $max = $V[$i-1][$j] + $gap_open;
        $gap_positions{"$i-1,$j"} = 1;  # Store gap position
      }
    } else {  # Existing vertical gap
      if ($V[$i-1][$j] + $gap_extend > $max) {
        $max = $V[$i-1][$j] + $gap_extend;
      }
    }

    $V[$i][$j] = $max;
    print OUT "V[$i][$j] has value $V[$i][$j]\n";
  }
}
