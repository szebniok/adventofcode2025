my @lines = "day3input.txt".IO.lines;
my @banks = @lines».comb».Int;
say sum @banks.map(*.combinations(2).max.join);
# 2 star
say sum @banks.map: -> $bank {
    my @best = $bank[*-12..*];
    for $bank[0..*-13].reverse {
        next if $_ < @best[0];
        @best = |max ($_, |@best).combinations(12);
    }
    @best.join
}