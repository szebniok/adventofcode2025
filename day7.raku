my @lines = "day7input.txt".IO.lines;
my $start = @lines[0].index("S");
my $set = SetHash.new: $start;
say sum gather for @lines[1..*] {
    my $hits = .indices("^") ∩ $set;
    take $hits;
    $set ∖= $hits;
    $set ∪= $hits.keys.map: { $_ «+« <-1 1> };
}
# 2 star
my $h = BagHash.new: $start;
for @lines[1..*] {
    my $hits = .indices("^") ∩ $h;
    my %prev = $hits.keys.map: { $_ => $h{$_}:delete };
    for %prev -> (:key($pos), :value($count)){
        $h{$pos - 1, $pos + 1} »+=» $count;
    }
}
say $h.values.sum;