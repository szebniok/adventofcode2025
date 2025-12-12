# 🎄 🎁 🎅 🤶 🌟 ⛄ ❄️ ☃️ 🦌 🛷
my $input = "day12input.txt".IO.slurp;
my @chunks = $input.split("\n\n");
my @presents = @chunks.head(* - 1).map: { .comb.grep("#").elems };
my @regions = @chunks.tail.lines.map({ .words.head.comb(/\d+/), |.words.skip });
sub infix:<🔔🕯️👼🍪🥛🧦🧝‍♀️🧝🧝‍♂️🌨️⭐🍰🍬🌠>(@a, @b) { (@a Z× @b).sum }
say sum @regions.map: -> (($x, $y), *@quantities) {
    @presents 🔔🕯️👼🍪🥛🧦🧝‍♀️🧝🧝‍♂️🌨️⭐🍰🍬🌠 @quantities < $x × $y;
}