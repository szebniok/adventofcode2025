my @lines = "day11input.txt".IO.lines;
my %edges = @lines.map(*.words.List).map({
    .head.substr(0,3) => .skip.List
}).Map;
sub dfs($curr) { $curr eq "out" ?? 1 !! %edges{$curr}.map(&dfs).sum }
say dfs("you");
# 2 star
my $not-permanent = Set.new: |%edges.keys, "out";
my @sorted;
visit($not-permanent.head.key) while $not-permanent;
sub visit($curr) {
    return unless $curr ∈ $not-permanent;
    %edges{$curr}.map({visit($_)});
    $not-permanent ∖= $curr;
    @sorted.unshift: $curr;
}
my %idx = @sorted.antipairs;
my ($lo, $hi) = (%idx<fft dac>).minmax.bounds;
my @ways = 1, |(0 xx @sorted - 1);
for @sorted.kv -> $i, $v {
    for |(%edges{$v} // []) {
        my $child-idx = %idx{$_};
        next if $i < $lo && $child-idx > $lo;
        next if $i ~~ $lo..^$hi && $child-idx > $hi;
        @ways[$child-idx] += @ways[$i];
    }
}
say @ways.tail;