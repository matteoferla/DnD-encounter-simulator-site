<p>Build from stats. For more options, such as buffs and nets or building from ability scores up, run the
python script or ask the author, who can happily add a default. Apart from the name, all these
    parameters are optional (default is commoner).</p>
<table class=clear id=table>
    <tr>
        <td class=clear>Name:</td>
        <td class=clear><input type=text id=name style="width:60%">
            <i class="far fa-question"
                           data-toggle="tooltip" title="The name of the creature. This is used for the summary and identical names can be used."></i>
        </td>
    </tr>
    <tr>
        <td class=clear>Base creature:</td>
        <td class=clear><input type=text id=base style="width:60%">
            <i class="far fa-question"
                          data-toggle="tooltip" title="Add a name to modify a preset creature"></i></td>
    </tr>
    <tr>
        <td class=clear>Alignment:</td>
        <td class=clear><input type=text id=alignment style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="The team the creature works for."></i>
        </td>
    </tr>
    <tr>
        <td class=clear>HP:</td>
        <td class=clear><input type=text id=hp style="width:60%">
           <i class="far fa-question" data-toggle="tooltip" title="hit points"></i></td>
    </tr>
    <tr>
        <td class=clear>AC:</td>
        <td class=clear><input type=text id=ac style="width:60%">
             <i class="far fa-question" data-toggle="tooltip" title="armour class"></i></td>
    </tr>
    <tr>
        <td class=clear>Initiative bonus:</td>
        <td class=clear><input type=text id=initiative_bonus style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="initiative bonus"></i></td>
    </tr>
    <tr>
        <td class=clear>attack parameters:</td>
        <td class=clear><input type=text id=attack_parameters style="width:60%">
            <i class="far fa-question"
                           data-toggle="tooltip" title="This is a tad complicated, sorry. Technically it is a list of list. It is a series of values between square brackets between square brakets, <i>e.g.</i> [[*club*, 2, 0, 4], [*club*, 2, 0, 4]]. Each square bracket block (list) denoted a part of an attack, namely a single attack will have only one, <i>e.g.</i> [[*sword of a thousand truths*, 7, 5, 16]], while a multiattack of two will have two as in the first example. The first element is a name, which is useless here as narration is disabled. The second is the attack bonus, the third is the damage bonus and the following are the dice. So [[*Batleth*,2,0,8,8]] is a +2, 2d8 and a [[*flaming greatsword*,3,1,6,6,4]] is a +3 2d6+d4+1.<br/> There is an encoding issue that I can only resolve by changing the quote of the string to asterisk."
                           title-position="bottom middle"></i></td>
    </tr>
    <tr>
        <td class=clear>Number of healing spells:</td>
        <td class=clear><input type=text id=healing_spells style="width:60%">
            <i class="far fa-question"
                          data-toggle="tooltip" title="Number of healing word spells (cantrip, only)"></i></td>
    </tr>
    <tr>
        <td class=clear>healing dice:</td>
        <td class=clear><input type=text id=healing_dice style="width:60%">
           <i class="far fa-question"
                          data-toggle="tooltip" title="number without the d. d4 is the default."></i></td>
    </tr>
    <tr>
        <td class=clear>healing bonus:</td>
        <td class=clear><input type=text id=healing_bonus style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="the bonus to your heal"></i></td>
    </tr>
    <tr>
        <td class=clear>Str:</td>
        <td class=clear><input type=text id=str style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="Strength ability, not bonus."></i></td>
    </tr>
    <tr>
        <td class=clear>Dex:</td>
        <td class=clear><input type=text id=dex style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="Dex ability, not bonus."></i></td>
    </tr>
    <tr>
        <td class=clear>Con:</td>
        <td class=clear><input type=text id=con style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="Constitution ability, not bonus."></i>
        </td>
    </tr>
    <tr>
        <td class=clear>Int:</td>
        <td class=clear><input type=text id=int style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="Intelligence ability, not bonus."></i>
        </td>
    </tr>
    <tr>
        <td class=clear>Wis:</td>
        <td class=clear><input type=text id=wis style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="Wisdom ability, not bonus."></i></td>
    </tr>
    <tr>
        <td class=clear>Cha:</td>
        <td class=clear><input type=text id=cha style="width:60%">
            <i class="far fa-question" data-toggle="tooltip" title="Charisma ability, not bonus."></i></td>
    </tr>
</table>
<br/>
<button onclick="AddC()" class="btn btn-raised btn-primary"><i class="far fa-shopping-cart"></i> Add</button>
<span id=confC><i class="far fa-check"></i></span>