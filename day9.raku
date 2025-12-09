my @lines = "day9input.txt".IO.lines;
my @red = @lines».split(",")».Int;
say @red.combinations(2).race.map({ [*] (.[0] »-« .[1])».abs »+» 1 }).max;
# 2 star
my @edges = (|@red, @red.head).rotor(2 => -1).map({ ([Z] $_)».minmax });
sub overlaps($a, $b) { $a.min < $b.max && $a.max > $b.min }
sub collision($X, $Y, $DX, $DY) { $X.&overlaps($DX) && $Y.&overlaps($DY) }
say @red.combinations(2).race.map(-> ($l, $r) {
    my ($X, $Y) = ([Z] ($l, $r)).map({.min + 1 minmax .max - 1});
    next unless ($X|$Y).elems;
    next if @edges.first(-> ($DX, $DY) { collision($X, $Y, $DX, $DY) });
    [*] ($l »-« $r)».abs »+» 1;
}).max;