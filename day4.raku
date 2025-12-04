my @lines = "day4input.txt".IO.lines;
my @grid = @lines.Array».comb».Array;
sub star1() {
    (^@grid X ^@grid[0]).grep: -> ($y, $x) {
        next unless @grid[$y][$x] eq "@";
        my $adj = +((-1..1) X (-1..1)).grep(*.any).grep: {
            my ($new-y, $new-x) = ($y, $x) »+« $_;
            next unless ($new-y, $new-x) ~~ (^@grid, ^@grid[0]);
            @grid[$new-y][$new-x] eq "@";
        }
        $adj < 4;
    }
}
say +star1();
# 2 star
say sum gather while my @removed = star1() {
    take +@removed;
    @grid[.[0]][.[1]] = "." for @removed;
}