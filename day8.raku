my @lines = "day8input.txt".IO.lines;
my @boxes = @lines».split(",")».Int;
sub circumfix:<‖ ‖>($p) { sqrt [+] ($p[0] »-« $p[1])»² }
my @dists = ((^@boxes X ^@boxes).map: -> ($a, $b) {
    next if $a >= $b;
    ($a, $b, ‖@boxes[$a], @boxes[$b]‖)
}).sort(*[2]);
my @parent = ^@boxes;
sub find($x) { @parent[$x] != $x ?? (@parent[$x] = find(@parent[$x])) !! $x }
sub union($x is copy, $y is copy) { @parent[find($x)] = find($y) }
for @dists.head(1000) -> ($a, $b, $) { union($a, $b) }
say [*] @parent.map(&find).BagHash.values.sort(-*).head(3);
# 2 star
my @last;
for @dists.skip(1000) -> ($a, $b, $) {
    @last = $a, $b if find($a) != find($b);
    union($a, $b);
}
say [*] @boxes[@last; 0];