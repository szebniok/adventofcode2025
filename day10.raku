my @lines = "day10input.txt".IO.lines;
my @machines = @lines.map: {
    given .words.Array { 
        .head.substr(1, *-1).comb.grep("#"):k.Set,
        .[1..*-2]».comb(/\d/)».Array,
        .tail.comb(/\d+/)
    }
};
sub dfs($goal, @buttons, $state = Set.new, $presses = 0) {
    return $presses if $state ≡ $goal;
    return ∞ unless @buttons;
    my ($top, @rest) = @buttons;
    dfs($goal, @rest, $state, $presses) min
    dfs($goal, @rest, $state ⊖ $top, $presses + 1);
}
say sum @machines.map: -> ($goal, @buttons, $) {
    dfs($goal, @buttons».Int».Set);
}
# 2 star
say sum gather for @machines -> ($, @buttons, @joltages) {
    my @data = (^@buttons).map({"(declare-const x$_ Int)(assert (>= x$_ 0))"});
    for @joltages.kv -> $i, $joltage {
        my $vars= @buttons.grep(*.first($i)):k.map("x"~*).join(" ");
        @data.push: "(assert (= (+ $vars) $joltage))";
    }
    @data.push: "(define-fun s () Int (+ {(^@buttons).map("x"~*)}))";
    @data.push: "(maximize (- s))(check-sat)(get-model)";
    my $p = run 'z3', '-in', :in, :out;
    $p.in.spurt: @data.join("\n") andthen $p.in.close;
    take $p.out.slurp.subst(/ x \d+ /, '', :g).comb(/\d+/).sum;
}