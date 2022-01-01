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
    <link rel="icon" href="${request.static_path('dnd_app:static/favicon.ico')}" type="image/x-icon"/>
    <link rel="shortcut icon" href="${request.static_path('dnd_app:static/favicon.ico')}" type="image/x-icon"/>
    <link rel="stylesheet" href="https://www.matteoferla.com/Font-Awesome-Pro/css/all.css">
    <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>


    <link rel="stylesheet" href="https://unpkg.com/bootstrap-material-design@4.1.1/dist/css/bootstrap-material-design.min.css" integrity="sha384-wXznGJNEXNG1NFsbm0ugrLFMQPWswR3lds2VeinahP8N0zJw9VWSopbjv2x7WCvX" crossorigin="anonymous">


    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="  crossorigin="anonymous"></script>

    <style>
    .res {width: 100%; text-align:center;}

    .jumbo-mod {
        background: white !important;
        font-family: 'Raleway', sans-serif;
        line-height: 1.1em;
        background-clip: border-box;
        border: 1px solid rgba(0, 0, 0, 0.12);
        border-radius: 0.125rem;
        box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
    }

.card-columns {
    column-count: 1; !important;
}

@media (min-width: 992px) {
.modal-lg,
.modal-xl {
max-width: 800px; !important;
}
.card-columns {
    column-count: 3; !important;
}

}

@media (min-width: 1200px) {
.modal-xl {
max-width: 1140px; !important;
}
.card-columns {
    column-count: 4; !important;
}
}


    </style>

    <%def name='card(section, title, icon, subtitle="")'>
        <div class="card">
            <div class="card-body">
            <h3 id="${section}" class="card-title"><i class="far ${icon}"></i> ${title} <i
            class="far fa-chevron-up" id="OFF_${section}" onclick="flip('${section}',0)"></i>
            <i class="far fa-chevron-down" id="ON_${section}" onclick="flip('${section}',1)"></i></h3>
                % if subtitle:
                    <h6 class="card-subtitle mb-2 text-muted">${subtitle}</h6>
                % endif

                <div class="card-text text-justify" id="DIV_${section}">
                <%include file="${section}.mako" />
            </div>
            </div>
        </div>
    </%def>

</head>
<body>

<div class="jumbotron  jumbotron-fluid jumbo-mod" style="background: white;">
<div class="container">
    <div class="row my-3">
        <div class="col-lg-1 offset-lg-2 hidden-sm">
            <img src="${request.static_path('dnd_app:static/Owlbear.jpg')}" width="100%" alt="owlbear icon"/>
        </div><!--icon-->

        <div class="col-lg-6 col-sm-12 align-middle">
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
            <a class="btn btn-outline-primary w-100 pb-1" href="https://www.matteoferla.com/email.html"
                                data-tooltip="Email the author. Suggestions welcome!"><i class="far fa-envelope"></i> Suggestions</a>
        </div><!--icon-->
    </div><!--title row-->

    <div class="row">
        <div class="col-lg-10 offset-lg-1 col-sm-12 text-justify">
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
    </div>
</div><!--jumbo-->
<div class="card">

</div>

<div class="card-columns px-3">
    ${card('setup_A', 'Encounter setup', 'fa-dragon', 'Option A: add default combattant from list')}
    ${card('setup_B', 'Encounter setup ', 'fa-book-dead','Option B: add combattant as a raw string')}
    ${card('setup_C', 'Encounter setup ', 'fa-flask-potion','Option C: build combattant')}
    ${card('lineup','Set teams','fa-scroll-old')}
    ${card('motive', 'Motives ', 'fa-hat-wizard')}
    ${card('work','Workings','fa-paw-claws')}
    ${card('future','Future work','fa-hand-holding-magic')}
    ${card('more','More','fa-dice-d3')}
    ${card('links','External links','fa-link')}
</div>


<p id=status></p>


<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" id="result_modal">
  <div class="modal-dialog modal-xl" style="max-width: 1140px !important; min-width: 80vw !important;">
    <div class="modal-content">
        <div class="modal-header">
        <h3 class="modal-title"><i class="far fa-treasure-chest"></i> Simulation Results</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-6">
                    <p id="OUT_battles"></p>
                    <p id="OUT_rounds"></p>
                    <p id="OUT_prediction"></p>
                    <p id="OUT_notes"></p>
                    <p id="OUT_team"></p>
                    <p id="OUT_combattant"></p>
                </div>
                    <div class="col-md-6"><div id="OUT_graph"></div>
                </div>
        </div>
                    <hr/>
                <a onClick='$("#OUT_sample").toggle("slow");'><i class="far fa-map"></i> Show one encounter</a>
                <div style="width:100%; height:200px; overflow:scroll; font-size:x-small" id="OUT_sample"></div>

    </div>
  </div>
</div>





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
    <script type="text/javascript" src="${request.static_path('dnd_app:static/dnd.js')}"></script>

<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
<script src="https://cdn.rawgit.com/FezVrasta/snackbarjs/1.1.0/dist/snackbar.min.js"></script>
</body>
</html>
