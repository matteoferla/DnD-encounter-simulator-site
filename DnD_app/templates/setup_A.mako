<h5><i class="far fa-paw-claws"></i> </h5>
<p>Pick a default creature, these are present in a csv file &mdash; the original was compiled by Jeff Fox
    and can be found on my GitHub page.</p>
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