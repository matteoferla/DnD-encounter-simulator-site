<p>The script empirically simulates a specified number of repeats of an encounter (<i>i.e.</i> 1,000
    times) in order to gain the probability of victory of defeat. damage and hp are not the sole factor
    in determining how an encounter may swing, therefore it may be impossible to predict with calculus,
    hence the simulation.</p>
<h3><i class="fas fa-chess-board"></i> Assumptions</h3>
<p>There are may factors involved, one of which is strategy, which is encoded here with a set of
    assumptions.</p>
<ul>
    <li>One targets an alive enemy with lowest hp (tag: "weakest"). Alternatives modes are random or
        that with highest average damage (tag: "fiercesomest")
    </li>
    <li>One heals only when there is no chance of wastage and one heals the most wonded character</li>
    <li>One uses net-throwing, grappling and other fancy moves only when there is turn economy &mdash;
        that is, one's team outnumbers the other.
    </li>
    <li>If there is turn economy and one is taking all the damage, one dodges.</li>
    <li>Some minor rules that make no difference</li>
</ul>
<h3><i class="far fa-chess-board"></i> Gridlessness</h3>
<p>This code does not take into account space. That means it assumes tactics on a grid don't matter:
    this is clearly wrong, but it is a lesser evil that encoding a <a href="#link">lot of behavioral
        rules</a> that are not obeyed in game &mdash;every group has a muchkin who will dive infront of
    a wizard's AoE just to kill stuff&mdash; or rules to solve non-trivial situations &mdash;player
    takes a 30 minute turn. Thanks to the many iterations, machine learning could be adopted making it a
    function minimisation problem, but it is overkill as no player is such a master strategist.</p>
<h3><i class="far fa-wand-magic"></i> Spell-list</h3>
<p>Spell-budgeting troubles players, therefore there is not much spellcasting, bar for a handful of
    cantrips.</p>