my $input = "day2input.txt".IO.slurp;
my @ranges = $input.split(",")».split("-")».Int;
say sum @ranges.map: -> ($a, $b) {
    sum ($a..$b).grep: { .substr(0, * ÷ 2) eq .substr(* ÷ 2) }
}
# 2 star
say sum @ranges.map: -> ($a, $b) {
    sum ($a..$b).grep: { /^ (\d+) $0+ $/ }
}