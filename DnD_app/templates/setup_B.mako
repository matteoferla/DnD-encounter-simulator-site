<p>Here one can add a raw json string (<span style="border-bottom:1px dotted"
                                          data-toggle="tooltip" title='A JSON string is how client-side javascript (JS) asynchronously sends objects to server-side python.<br/> Okay, that was just to be user-unfriendly. <br/>In this field, you can just add a name in double quotes, <i>e.g.</i><br/>"cthulhu"<br/>or add a more complex entry, such as a list (JS: array) of names enclosed by square braces and separated by a comma,<i>e.g.</i><br/>["tarrasque","commoner","commoner"]<br/>Instead of a name, you can add a dictionary (JS: object) within the list, that is to say a series of key/value pairs, where the keys are the options to customise the creature.<br/>There are many and I have not written a summary of them and the Creature instantiation is a messy knot as the code is very tollerant of half complete stats (when it cannot calculate it will use commoner stats)... sorry.<br/>{"name"="Barkskin goblin","base"="goblin", "sc_ability"="wis", "buff"="cast_barkskin", "buff_spells"=10,"wis"=30}<br/>'>details</span>.
Note that there are more names than in the list above as the hardcoded creatures have not been moved to
the beastiary spreadsheet (<span style="border-bottom:1px dotted"
                                 data-toggle="tooltip" title="(The aforementhioned list can be seen in the method _fill_from_preset of the class Creature in the python script.<br/> They are mostly very cryptic (such as a_b_dragon and y_b_dragon, polar, allo, anky) and several (such as frost_giant and hill_giant), are present in the beastiary. There are some hero builds such as barbarian, netsharpshooter and druid.">examples</span>).
</p>
<div class="input-group mb-3 w-100">
  <textarea id=def style="width: 80%"></textarea>
  <div class="input-group-append">
    <button type="button" onclick="AddB()" class="btn btn-raised btn-primary"><i class="far fa-shopping-cart"></i> Add</button>
  </div>
</div>
<span id=confB><i class="far fa-check"></i></span><span id=failB><i class="far fa-times"></i></span>