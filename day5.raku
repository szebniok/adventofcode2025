my $input = "day5input.txt".IO;
my ($fresh-input, $ingredients-input) = $input.split("\n\n");
my @fresh = $fresh-input.lines».split("-")».Int».minmax;
my @ingredients = $ingredients-input.lines».Int;
say +@ingredients.grep(* ∈ @fresh.any);
# 2 star
@fresh .= sort;
say sum gather while @fresh {
    my $curr = @fresh.shift;
    while @fresh && @fresh.head.min ≤ $curr.max {
        $curr = $curr.min..max($curr.max, @fresh.shift.max);
    }
    take $curr.Int;
}