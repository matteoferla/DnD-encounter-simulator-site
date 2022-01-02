<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="author" content="Matteo Ferla">
    <meta name="description" content="D&D 5e encounter simulator">
    <meta name="keywords"
          content="DnD, D&D, 5e, Dungeons and Dragons, next, online, python, battle, encounter, simulator">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>D&D Encounter simulator</title>
    <style>
    .res {width=100%; text-align:center;}
    </style>
    <link rel="icon" href="${request.static_path('DnD_app:static/favicon.ico')}" type="image/x-icon"/>
    <link rel="shortcut icon" href="${request.static_path('DnD_app:static/favicon.ico')}" type="image/x-icon"/>
    <link rel="stylesheet" href="http://www.matteoferla.com/Font-Awesome-Pro/css/all.css">
    <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>


    <link rel="stylesheet" href="https://unpkg.com/bootstrap-material-design@4.1.1/dist/css/bootstrap-material-design.min.css" integrity="sha384-wXznGJNEXNG1NFsbm0ugrLFMQPWswR3lds2VeinahP8N0zJw9VWSopbjv2x7WCvX" crossorigin="anonymous">


    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="  crossorigin="anonymous"></script>

</head>
<body style="background: white; font-family: 'Raleway', sans-serif; line-height: 1.1em">

<div class="container-fluid">

    <div class="row my-5">
        <div class="col-lg-1 offset-lg-2 hidden-sm">
            <img src="${request.static_path('DnD_app:static/Owlbear.jpg')}" width="100%" alt="owlbear icon"/>
        </div><!--icon-->

        <div class="col-lg-5 col-sm-12 align-middle">
        <h1 style="display:inline">D&D 5e Encounter Simulator</h1>
        </div><!--title-->

        <div class="col-lg-2 col-sm-12">
            <!-- <iframe src="https://ghbtns.com/github-btn.html?user=matteoferla&repo=DnD-battler&type=star&count=true&size=small"
                                    frameborder="0" scrolling="0" width="160px" height="30px"></iframe> -->
            <a href="https://github.com/matteoferla/DnD-battler/" target="_blank" class="btn btn-outline-primary w-100 pb-1">
                <i class="fab fa-github"></i> GitHub
                <span class="fa-layers fa-fw">
                <i class="fas fa-star"></i>
                <span class="fa-layers-text fa-inverse" data-fa-transform="shrink-8 down-3" style="font-weight:900">18</span>
            </span>
            </a>
            <a class="btn btn-outline-primary w-100 pb-1" href="http://www.matteoferla.com/email.html"
                                data-tooltip="Email the author. Suggestions welcome!"><i class="far fa-envelope"></i> Suggestions</a>
        </div><!--icon-->
    </div><!--title row-->

    <div class="row">
        <div class="col-lg-8 offset-lg-2 col-sm-12 text-justify">
            <p style="text-align:justify; text-align-last:center;">
                <span style="float: left; color: #903; font-size: 64px; line-height: 48px; padding-top: 0px; padding-right: 6px; padding-left: 3px; font-family: Georgia;">T</span>
                HIS online tool calculates the victory probabilities in a D&amp;D encounter. It relies on <a
                    href="https://github.com/matteoferla/DnD-battler" target="_blank">a python script <i class="far fa-external-link-square"></i></a>,
                which simulates an encounter 1,000 times for statistical accuracy. The characters can be inputted in a
                variety of ways ranging from a preset to an incomplete list of parameters, which the code will either
                calculate from others or default to the value of a commoner. The presets are based on <a
                    href="https://raw.githubusercontent.com/matteoferla/DnD-battler/master/beastiary.csv">a monster manual table ("beastiary.csv")
                <span style="text-decoration:none">&nbsp;<i class="far fa-download"></i></span></a> it references a
                series of assumptions (tactical decisions) detailed in the <a href="#work">Workings section</a> and in more
                technical detail in the <a href="https://github.com/matteoferla/DnD-battler" target=_blank>documetation
                of the code <i class="far fa-external-link-square"></i></a>. For example, due to the complexity of the tactical decisions involved, which human players
                often fail at, the encounters are performed with the assumption that everyone borders everyone. The script
                is 5e focused in the way it handles crits, conditions, advatages and disadvantages.</p>
            <p style="text-align:justify; text-align-last:center;">Here are provided three ways to input the list of
                combattants. The first is picking creatures from the beastiary table, the second relies on a set of
                hardcoded creatures, many which have not yet been moved to the beastiary table and the third allows
                custom creatures to be added. The latter is a tad limited: for example nets, <i>barkskin</i> and rage
                cannot be added despite the fact that the presets "netsharpshooter", "druid" and "barbarian" use them.<br/>
                NB. The program times out after 10 seconds, therefore if the battles are lengthy (<i>e.g.</i> one good
                tarrasques vs. one evil tarrasques) it will have less than the default 1,000 rounds.
            </p>
        </div><!--abs-->
    </div><!--abs row-->

    <div class="row pt-4 px-3">
    <div class="col-lg-6 col-sm-12 px-5">
        <h2><i class="far fa-dragon"></i> Encounter setup <i
            class="far fa-chevron-up" id="OFF_setup" onclick="flip('setup',0)"></i>
            <i class="far fa-chevron-down" id="ON_setup" onclick="flip('setup',1)"></i>
    </h2>
        <div id="DIV_setup">
            <h3><i class="far fa-paw-claws"></i> Option A: add default combattant from list</h3>
            Pick a default creature, these are present in a csv file &mdash; the original was compiled by Jeff Fox
            and can be found on my GitHub page.<br/>
            <div class="row">
                    <div class="col-10">
                        <div class="input-group mb-3">
            <select id=drop>
                <option value="cthulhu">Select creature</option>
                ${beasts|n}
            </select>
                <div class="input-group-append">
                    <button onclick="AddA()" class="btn btn-raised btn-primary"><i class="far fa-shopping-cart"></i> Add</button>
                </div>
            </div>
                    </div>
                    <div class="col-2">
                        <span id=confA><i class="far fa-check"></i></span>
                    </div>
            </div>


            <h3><i class="far fa-book-dead"></i> Option B: add combattant as a raw string</h3>
            Here one can add a raw json string (<span style="border-bottom:1px dotted"
                                                      data-tooltip='A JSON string is how client-side javascript (JS) asynchronously sends objects to server-side python.<br/> Okay, that was just to be user-unfriendly. <br/>In this field, you can just add a name in double quotes, <i>e.g.</i><br/>"cthulhu"<br/>or add a more complex entry, such as a list (JS: array) of names enclosed by square braces and separated by a comma,<i>e.g.</i><br/>["tarrasque","commoner","commoner"]<br/>Instead of a name, you can add a dictionary (JS: object) within the list, that is to say a series of key/value pairs, where the keys are the options to customise the creature.<br/>There are many and I have not written a summary of them and the Creature instantiation is a messy knot as the code is very tollerant of half complete stats (when it cannot calculate it will use commoner stats)... sorry.<br/>{"name"="Barkskin goblin","base"="goblin", "sc_ability"="wis", "buff"="cast_barkskin", "buff_spells"=10,"wis"=30}<br/>'>details</span>.
            Note that there are more names than in the list above as the hardcoded creatures have not been moved to
            the beastiary spreadsheet (<span style="border-bottom:1px dotted"
                                             data-tooltip="(The aforementhioned list can be seen in the method _fill_from_preset of the class Creature in the python script.<br/> They are mostly very cryptic (such as a_b_dragon and y_b_dragon, polar, allo, anky) and several (such as frost_giant and hill_giant), are present in the beastiary. There are some hero builds such as barbarian, netsharpshooter and druid.">examples</span>).
            <br/>
            <div class="input-group mb-3 w-100">
              <textarea id=def style="width: 80%"></textarea>
              <div class="input-group-append">
                <button type="button" onclick="AddB()" class="btn btn-raised btn-primary"><i class="far fa-shopping-cart"></i> Add</button>
              </div>
            </div>
            <span id=confB><i class="far fa-check"></i></span><span id=failB><i class="far fa-times"></i></span>
            <br/>
            <h3><i class="far fa-flask-potion"></i> Option C: build combattant</h3>
            Build from stats. For more options, such as buffs and nets or building from ability scores up, run the
            python script or ask the author, who can happily add a default. Apart from the name, all these
            parameters are optional (default is commoner).<br/>
            <table class=clear id=table>
                <tr>
                    <td class=clear>Name:</td>
                    <td class=clear><input type=text id=name style="width:60%">
                        <i class="far fa-question"
                                       data-tooltip="The name of the creature. This is used for the summary and identical names can be used."></i>
                    </td>
                </tr>
                <tr>
                    <td class=clear>Base creature:</td>
                    <td class=clear><input type=text id=base style="width:60%">
                        <i class="far fa-question"
                                      data-tooltip="Add a name to modify a preset creature"></i></td>
                </tr>
                <tr>
                    <td class=clear>Alignment:</td>
                    <td class=clear><input type=text id=alignment style="width:60%">
                        <i class="far fa-question" data-tooltip="The team the creature works for."></i>
                    </td>
                </tr>
                <tr>
                    <td class=clear>HP:</td>
                    <td class=clear><input type=text id=hp style="width:60%">
                       <i class="far fa-question" data-tooltip="hit points"></i></td>
                </tr>
                <tr>
                    <td class=clear>AC:</td>
                    <td class=clear><input type=text id=ac style="width:60%">
                         <i class="far fa-question" data-tooltip="armour class"></i></td>
                </tr>
                <tr>
                    <td class=clear>Initiative bonus:</td>
                    <td class=clear><input type=text id=initiative_bonus style="width:60%">
                        <i class="far fa-question" data-tooltip="initiative bonus"></i></td>
                </tr>
                <tr>
                    <td class=clear>attack parameters:</td>
                    <td class=clear><input type=text id=attack_parameters style="width:60%">
                        <i class="far fa-question"
                                       data-tooltip="This is a tad complicated, sorry. Technically it is a list of list. It is a series of values between square brackets between square brakets, <i>e.g.</i> [[*club*, 2, 0, 4], [*club*, 2, 0, 4]]. Each square bracket block (list) denoted a part of an attack, namely a single attack will have only one, <i>e.g.</i> [[*sword of a thousand truths*, 7, 5, 16]], while a multiattack of two will have two as in the first example. The first element is a name, which is useless here as narration is disabled. The second is the attack bonus, the third is the damage bonus and the following are the dice. So [[*Batleth*,2,0,8,8]] is a +2, 2d8 and a [[*flaming greatsword*,3,1,6,6,4]] is a +3 2d6+d4+1.<br/> There is an encoding issue that I can only resolve by changing the quote of the string to asterisk."
                                       data-tooltip-position="bottom middle"></i></td>
                </tr>
                <tr>
                    <td class=clear>Number of healing spells:</td>
                    <td class=clear><input type=text id=healing_spells style="width:60%">
                        <i class="far fa-question"
                                      data-tooltip="Number of healing word spells (cantrip, only)"></i></td>
                </tr>
                <tr>
                    <td class=clear>healing dice:</td>
                    <td class=clear><input type=text id=healing_dice style="width:60%">
                       <i class="far fa-question"
                                      data-tooltip="number without the d. d4 is the default."></i></td>
                </tr>
                <tr>
                    <td class=clear>healing bonus:</td>
                    <td class=clear><input type=text id=healing_bonus style="width:60%">
                        <i class="far fa-question" data-tooltip="the bonus to your heal"></i></td>
                </tr>
                <tr>
                    <td class=clear>Str:</td>
                    <td class=clear><input type=text id=str style="width:60%">
                        <i class="far fa-question" data-tooltip="Strength ability, not bonus."></i></td>
                </tr>
                <tr>
                    <td class=clear>Dex:</td>
                    <td class=clear><input type=text id=dex style="width:60%">
                        <i class="far fa-question" data-tooltip="Dex ability, not bonus."></i></td>
                </tr>
                <tr>
                    <td class=clear>Con:</td>
                    <td class=clear><input type=text id=con style="width:60%">
                        <i class="far fa-question" data-tooltip="Constitution ability, not bonus."></i>
                    </td>
                </tr>
                <tr>
                    <td class=clear>Int:</td>
                    <td class=clear><input type=text id=int style="width:60%">
                        <i class="far fa-question" data-tooltip="Intelligence ability, not bonus."></i>
                    </td>
                </tr>
                <tr>
                    <td class=clear>Wis:</td>
                    <td class=clear><input type=text id=wis style="width:60%">
                        <i class="far fa-question" data-tooltip="Wisdom ability, not bonus."></i></td>
                </tr>
                <tr>
                    <td class=clear>Cha:</td>
                    <td class=clear><input type=text id=cha style="width:60%">
                        <i class="far fa-question" data-tooltip="Charisma ability, not bonus."></i></td>
                </tr>
            </table>
            <br/>
            <button onclick="AddC()" class="btn btn-raised btn-primary"><i class="far fa-shopping-cart"></i> Add</button>
            <span id=confC><i class="far fa-check"></i></span>
            <br/>
            <h3><i class="far fa-scroll-old"></i> Lineup</h3>
            <div style="padding:5px">
                <div id=lineup style="padding:10px; ; min-height:2em; border:1px lightgrey; background:gainsboro">
                    <br/><br/></div>
            </div>
            <div id="lineup_graph"></div>
            <div id="lineup_side"></div>
            <br/>
            <div class="btn-group align-self-center" role="group" aria-label="Calculate">
                <button type="button"  onclick="duel();" id="calculate_button" class="btn btn-raised btn-success"><i class="far fa-dungeon"></i> Calculate</button>
            <button type="button"  onclick='initial();console.log("cleared");$("#lineup").html("")' class="btn btn-raised btn-warning"><i class="far fa-dumpster-fire"></i>
                Clear
            </button>
            </div>



            <br/>
        </div>
    </div><!--setup-->
    <div class="col-lg-6 col-sm-12 px-5">
        <h2><i class="far fa-hat-wizard"></i> Motives <i class="far fa-chevron-up" id="OFF_motive" onclick="flip('motive',0)"></i><i
                    class="far fa-chevron-down" id="ON_motive" onclick="flip('motive',1)"></i></h2>
            <div id="DIV_motive" class="text-justify">
                <p>D&D is an amazing game, but encounters can get tedious when they are not a challenge. Conversely, too
                    much of a challenge leads to a dissapointing series of GM fiats or, worse, a total party kill, a
                    scenario to avoid as it is disappointing for all or worse. Therefore a correct balance is needed. As
                    a result the GM guide has a table that can be used to calculate how hard an encounter is, which is
                    not overly accurate. I have been in too many encounters that on paper should have been deadly, while
                    on the table have been a walk in the park. The reason for this is that a single value cannot
                    represent the strength of a party.</p>
                <p> Consequently, to address and <a href="#links">analyse</a> this and <a href="#links">to trial new
                    weapons</a>, I wrote a <a href="#links">python script</a> to simulate battles.</p>
            </div>
            <h2 id=work><i class="far fa-dice-d20"></i> Workings <i class="far fa-chevron-up" id="OFF_work" onclick="flip('work',0)"></i><i
                    class="far fa-chevron-down" id="ON_work" onclick="flip('work',1)"></i></h2>
            <div id="DIV_work" class="text-justify">
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
                </div>
            <h2 id="future"><i class="far fa-hand-holding-magic"></i> Future work <i class="far fa-chevron-up" id="OFF_future" onclick="flip('future',0)"></i><i
                    class="far fa-chevron-down" id="ON_future" onclick="flip('future',1)"></i></h2>
            <div id="DIV_future" class="text-justify">
                <ul class="fa-ul">
                    <li><i class="fa-li far fa-pencil"></i> Add more fields for custom creatures (the sole reason why
                        there are not more is the layout needs changing).
                    </li>
                    <li><i class="fa-li far fa-database"></i> Add more creatures to the excel sheet, especially PCs.</li>
                    <li><i class="fa-li far fa-database"></i> Allow user submissions.</li>
                    <li><i class="fa-li far fa-search"></i> Get creature info on line-up from server and add option to
                        delete specific ones.
                    </li>
                    <li><i class="fa-li far fa-bug"></i> Double check with the PHB and MM some parts (TODO comments in
                        code).
                    </li>
                    <li><i class="fa-li far fa-rocket"></i> Introduce machine learning to the code, so that it accepts
                        more spells and can work on a grid.
                    </li>
                </ul>
            </div>
            <h2>More <i class="far fa-chevron-up" id="OFF_more" onclick="flip('more',0)"></i><i
                    class="far fa-chevron-down" id="ON_more" onclick="flip('more',1)"></i></h2>
            <div id="DIV_more" class="text-justify">
                <p>This is the webserver version of a python script that is a lot more complex and customisable, such as
                    running multiple analyses changing on parameter or running a single button and getting the verbose
                    description of the battle. For technical reasons, the simulations are limited to 1,000 battles
                    (encounters) and no custom spells are allowed as spells are encoded as method references which might
                    lead to vulnerability.</p>
                <p>See <a href="#links">GitHub</a> for more. </p></div>

            <h2 id="links">External links <i class="far fa-chevron-up" id="OFF_link" onclick="flip('link',0)"></i><i
                    class="far fa-chevron-down" id="ON_link" onclick="flip('link',1)"></i></h2>
            <div id="DIV_link" class="text-justify">
                <ul class="fa-ul">
                    <li><i class="fa-li fab fa-github"></i> <a href="https://github.com/matteoferla/DnD-battler">GitHub
                        repository of the D&D battle python script</a></li>
                    <li><i class="fa-li far fa-comment"></i> <a
                            href="http://www.giantitp.com/forums/showthread.php?408755-D-amp-D-Battle-simulator">Discussion
                        on Giant in the Playground about the script</a></li>
                    <li><i class="fa-li far fa-dagger"></i> <a
                            href="http://squidonius.blogspot.co.uk/2015/03/d-5e-weapon-analysis-and-suggestions.html">An
                        analysis of D&D weapons</a></li>
                    <li><i class="fa-li far fa-bow-arrow"></i> <a
                            href="http://squidonius.blogspot.co.uk/2015/04/d-battle-simulator.html">Analysis of
                        simulated battle results (part 1)</a></li>
                    <li><i class="fa-li far fa-axe-battle"></i> <a
                            href="http://squidonius.blogspot.co.nz/2015/04/d-battle-simulator-part-2.html">Analysis of
                        simulated battle results (part 2)</a></li>
                    <li><i class="fa-li far fa-envelope"></i> <a
                            href="www.matteoferla/email.html">Author's
                        email</a>: suggestions welcome
                    </li>
                    <li><i class="fa-li far fa-cogs"></i> <a href="/review">Backpage
                        to seem all battles since last server reboot</a></li>
                </ul>
            </div>
    </div><!--wordy-->
    </div><!-- row main-->

<div class="row">
    <div class="col-lg-10 offset-lg-1 col-sm-12">
        <p id=status></p>

            <h2><i class="far fa-treasure-chest"></i> Simulation Results <i class="far fa-chevron-up" id="OFF_result" onclick="flip('result',0)"></i><i
                    class="far fa-chevron-down" id="ON_result" onclick="flip('result',1)"></i></h2>
            <div id="DIV_result">
                <table style="width:100%; max-width:100%">
                    <tr><td style="width:50%; max-width:50%">
                    <p id="OUT_battles"></p>
                    <p id="OUT_rounds"></p>
                    <p id="OUT_prediction"></p>
                    <p id="OUT_notes"></p>
                    <p id="OUT_team"></p>
                    <p id="OUT_combattant"></p>
                    <a onClick='$("#OUT_sample").toggle("slow");'><i class="far fa-map"></i> Show one encounter</a>
                    <div style="width:100%; height:200px; overflow:scroll; font-size:x-small" id="OUT_sample"></div>
                </td>
                    <td><div id="OUT_graph"></div></td>
                    </tr>
                </table>
                <div >
                </div>
            </div>
    </div><!--results-->
</div><!-- results row-->

</div><!--container-->




<script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js" integrity="sha384-fA23ZRQ3G/J53mElWqVJEGJzU0sTs+SvzG8fXVWP+kJQ1lwFAOkcUOysnlKJC33U" crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-material-design@4.1.1/dist/js/bootstrap-material-design.js" integrity="sha384-CauSuKpEqAFajSpkdjv3z9t8E7RlpJ1UP0lKM/+NdtSarroVKu069AlsRPKkFBz9" crossorigin="anonymous"></script>
<script>$(document).ready(function() { $('body').bootstrapMaterialDesign(); });</script>
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-66652240-1', 'auto');
ga('send', 'pageview');


</script>
    <script type="text/javascript" src="${request.static_path('DnD_app:static/dnd.js')}"></script>

<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
</body>
</html>
