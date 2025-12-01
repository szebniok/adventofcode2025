my @lines = "day1input.txt".IO.lines;
my $dial = 50;
say sum gather for @lines {
    $dial = ($dial + .trans(<L R> => <- +>)) % 100;
    take 1 if $dial == 0;
}
# 2 star
$dial = 50;
say sum gather for @lines {
    my ($dir, $val) = (.substr(0,1), .substr(1).Int);
    take $val div 100;
    $val %= 100;
    my $new-dial = $dial + ($dir eq "L" ?? -$val !! $val);
    take 1 if $dial != 0 && (0|100) ∈ ($dial minmax $new-dial);
    $dial = $new-dial % 100;
}