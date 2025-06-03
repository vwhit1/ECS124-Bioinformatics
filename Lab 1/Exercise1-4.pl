# Consider the following program:
# $silly = 'tttTTT';
# $silly =~ tr/tT/Tt;
# print $silly;

# This will just print ttttt because the t's get converted to Ts
# and then all of them are T's, so they all become t's.

# In order to actually switch the uppercase and lowercase, here's one way to do it
$silly = 'tttTTT';
$silly =~ tr/t/u; #only works if there's no u in the original
$silly =~ tr/uT/Tt;
print $silly;