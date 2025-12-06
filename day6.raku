my @lines = "day6input.txt".IO.lines;
my @grid = @lines».words;
my (@numbers, @ops) := @grid[^(*-1), *-1];
sub get-op($op) { &::("infix:<{$op}>") }
say sum (@ops Z ([Z] @numbers)).map: -> ($op, $col) {
    $col.reduce(get-op($op));
}
# 2 star
say sum gather for ([Z] @lines».comb).reverse {
    next if .all eq " ";
    state @tally;
    @tally.push: .head(*-1).join;
    if .tail eq "+"|"*" {
        take @tally.reduce(get-op(.tail));
        @tally = ();
    }
}