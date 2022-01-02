

/* if (window.jQuery) {  
    console.log('we have jquery'); 
} else {
    console.log('we don"t have jquery');
} */

function flip(name,way) {
	if (way ==1) {
	$("#OFF_"+name).show();
	$("#ON_"+name).hide();
	$("#DIV_"+name).hide('slow');
		}
	else {
	$("#OFF_"+name).hide();
	$("#ON_"+name).show();
	$("#DIV_"+name).show('slow');
		}
	}

// function duel_t() {
// 	$.ajax({
//   method: "POST",
//   url: "simulate",
//   data: []
// })
//   .done(function( msg ) {
//     alert( "Data Saved: " + msg );
//   });
// 	}


function Output (reply) {
	$('#result_modal').modal();
	$("#OUT_battles").html("");
	$("#OUT_rounds").html("");
	$("#OUT_prediction").html("");
	$("#OUT_notes").html("");
	$("#OUT_team").html("");
	$("#OUT_combattant").html("");

	$('#d20toast').hide();
	$.snackbar({
			content: "<i class=\"far fa-mandolin\"></i> Calculations complete", // text of the snackbar
			style: "toast", // add a custom class to your snackbar
			timeout: 2000, // time in milliseconds after the snackbar autohides, 0 is disabled
			htmlAllowed: true, // allows HTML as content value
			onClose: function(){ } // callback called when the snackbar gets closed.
		});
	let data = JSON.parse(reply);
	header={notes: "Notes",
		rounds:"Total number of rounds fought",
		battles:"Total number of battles fought" ,
		prediction:"Rought predictions",
		}
	for (k in header) {
	$("#OUT_"+	k).html(header[k]+": "+data[k]);
		}
	tmax=100/4;
	t="<table class=res><thead><tr>"+
	"<th width='"+ tmax +"%'>Team name</th>"+
	"<th width='"+ tmax +"%'>Number of victories</th>"+
	"<th width='"+ tmax +"%'>Number of close calls</th>"+
	"<th width='"+ tmax +"%'>Number of perfects</th>"+"</tr></thead><tbody>";
	for (ti=0; ti<data.team_names.length; ti++) {
		t+="<tr><th width='"+ tmax +" %'>"+data.team_names[ti]+"</th><td width='"+tmax+"%'>"+
		data.team_victories[ti]+"</td><td width='"+tmax+"%'>"+
		data.team_close[ti]+"</td><td width='"+tmax+"%'>"+
		data.team_perfects[ti]+"</td>"+"</tr>";
		}
	t+="</tbody></table>";
	$("#OUT_team").html(t);
	cmax=100/6;	
	c="<table class=res><thead><tr>"+
	"<th width='"+ cmax +"%'>Combattant</th>"+
	"<th width='"+ cmax +"%'>Team</th>"+
	"<th width='"+ cmax +"%'>avg damage</th>"+
	"<th width='"+ cmax +"%'>avg hits</th>"+
	"<th width='"+ cmax +"%'>avg misses</th>"+
	"<th width='"+ cmax +"%'>avg rounds</th>"+
	"</tr></thead><tbody>";	
	for (ci=0; ci<data.combattant_names.length; ci++) {
		c+="<tr><th width='"+ cmax +" %'>"+data.combattant_names[ci]+"</th><td width='"+ cmax +" %'>"+
		data.combattant_names[ci]+"</td><td width='"+ cmax +" %'>"+
		parseFloat(data.combattant_damage_avg[ci]).toFixed(2)+"</td><td width='"+ cmax +" %'>"+
		parseFloat(data.combattant_hit_avg[ci]).toFixed(2)+"</td><td width='"+ cmax +" %'>"+
		parseFloat(data.combattant_miss_avg[ci]).toFixed(2)+"</td><td width='"+ cmax +" %'>"+
		parseFloat(100*data.combattant_rounds[ci]).toFixed(0)+" %</td>"+
		"</tr>";
		}
	c+="</table>";
    $("#OUT_combattant").html(c);
	$("#OUT_sample").html(data['sample_encounter']);

	var graphData={'ref': {  x: data.combattant_damage_avg,
			  y: data.combattant_hit_avg,
			  mode: 'markers',
			  type: 'scatter',
			  name: 'halo = diff. from 100% survival',
			  text: [],
			marker: {size: 10, color: 'black'}
			}
	};
	for (var i=0; i < data.combattant_alignments.length; i++) {
		// init
		if (! graphData[data.combattant_alignments[i]]) {
			graphData[data.combattant_alignments[i]]= {
			  x: [],
			  y: [],
			  mode: 'markers',
			  type: 'scatter',
			  name: data.combattant_alignments[i],
			  text: [],
			marker: {size: []}
			};
		}
		//fill
		graphData[data.combattant_alignments[i]]['x'].push(data.combattant_damage_avg[i]);
		graphData[data.combattant_alignments[i]]['y'].push(data.combattant_hit_avg[i]);
		graphData[data.combattant_alignments[i]]['text'].push(data.combattant_names[i]);
		graphData[data.combattant_alignments[i]]['marker']['size'].push(data.combattant_rounds[i] * 10);

	}

	var layout = {
	  xaxis: {
	    title: 'Avg Damage'
	  },
	  yaxis: {
	    title: 'Avg Hits'
	  },
	  title:'Combatant performance',
	  legend: {orientation: 'h', x: 0.1, y: -0.5}
	};

	Plotly.newPlot('OUT_graph', Object.values(graphData), layout);

	}

function duel() {
$('#calculate_button').attr("disabled", "disabled");
$.snackbar({
			id:'d20toast',
			content: "<i class='far fa-dice-d20 fa-spin'></i> Simulation in progress.", // text of the snackbar
			style: "toast", // add a custom class to your snackbar
			timeout: 0, // time in milliseconds after the snackbar autohides, 0 is disabled
			htmlAllowed: true, // allows HTML as content value
			onClose: function(){ } // callback called when the snackbar gets closed.
		});
$("#status").html("");

$.ajax({
            url: "/simulate",
            type: 'POST',
            dataType: 'json',
            data: JSON.stringify(lineup),
            success: Output,
            error: function() {
                $("#status").html('<div class="alert alert-danger" role="alert"><i class="far fa-skull-crossbones"></i> Oh Snap. Nothing back.</div>');
            }
        });
$('#calculate_button').removeAttr('disabled');
}

function Add(newbie) {
	lineup.push(newbie);
	update_lineup();
	}

function AddA() {
	var newbie=$("#drop").val();
	Add(newbie);
	$("#confA").show("slow");
	$("#confA").hide("slow");
	}

function AddB() {
	try{
	let newbie=JSON.parse($("#def").val());
	if (Array.isArray(newbie)) {
		lineup.push(...newbie);
	}
	else {lineup.push(newbie);}
	} catch (err) {
		console.log("ISSUE ADDING INPUT JSON");
		console.log($("#def").val());
		$("#failB").show("slow");
		$("#failB").hide("slow");
		return 0
		}
	
	$("#lineup_code").html(lineup);
	update_lineup();
	$("#confB").show("slow");
	$("#def").val("");
	$("#confB").hide("slow");
	}
	
function AddC() {
		let newbie={};
	$("#table").find('input').each(function(index, element) {
        let key=$(this).attr('id');
		var v=$("#"+key).val();
		if (!!v) {newbie[key]=$("#"+key).val();}
			$("#"+key).val("");
    });
	Add(newbie);
	$("#confC").show("slow");
	$("#confC").hide("slow");
	}

function removeCombattant(i) {
	lineup.splice(i,1);
	update_lineup();
}

function initial() {
	$("#def").keyup(function(event){if(event.keyCode == 13){AddB();}});
	$("#confA").hide();
	$("#confB").hide();
	$("#confC").hide();
	$("#failB").hide();
	window.lineup=[];
	$(".fa-chevron-up").hide();
	$("#ON_result").hide();
	$("#OFF_result").show();
	$("#DIV_result").hide();
	$("#OUT_sample").hide();
	$('[data-toggle="tooltip"]').tooltip();
	}

function fix_doubles() {
	var unique={};
	for (var i=0; i < lineup.length; i++) {
		if (!! lineup[i].replace) { //is string-like
			if (!! unique[lineup[i]]) {
				unique[lineup[i]]++;
				lineup[i]={base: lineup[i], name: lineup[i]+' #'+unique[lineup[i]].toString()};
			} else {
				unique[lineup[i]]=1;
			}
		} else { // is dictionary.
			if (! lineup[i]['name']) {
				lineup[i]['name']='Nameless'}
			var name ='';
			if (lineup[i]['name'].indexOf(' #') != -1) {
				name = lineup[i]['name'].split(' #')[0]
			} else {
				name = lineup[i]['name'];
			}
			if (unique[name]) {
				unique[name]++;
				lineup[i]['name']=name+' #'+unique[name].toString();
			} else {
				unique[lineup[i]['name']]=1;
			}
		}
	}
}

function give_lineup_results(result) {
	Plotly.newPlot('lineup_graph', result.sides, {title: 'HP per side (the 2nd crudest metric of balance)'});
	$('#lineup_side').html('<table style="width: 100%"><thead><tr><th>Name</th></tr></thead><tbody></tbody></table>');
	$('#lineup_code').html(JSON.stringify(lineup));
	var sides= result.sides[0].labels;
	if (! sides.includes('other')) {sides.push('other');}
	sides.forEach(function (side) {
			$('#lineup_side thead tr').append('<th>'+side+'</th>');
		});
	result.combatants.forEach(function (combatant, index) {
		$('#lineup_side tbody').append('<tr></tr>');
		$('#lineup_side tr:last').append('<td>'+combatant.name+' <span class="kill_me" onclick="removeCombattant('+index+')"><i class="far fa-trash"></i></span></td>');
		sides.forEach(function (side) {
			var clean=combatant.name.split(' #')[0]+'x'.repeat(parseInt(combatant.name.split(' #')[1]));
			$('#lineup_side tr:last').append('<td><input type="radio" name="'+clean+'" value="'+side+'" class="combatant_side" data-fullname="'+combatant.name+'" ></td>');
			$(':radio[name="'+clean+'"][value="'+combatant.side+'"]').prop("checked", true);
		});
		$('.combatant_side').change(function () {
				if ($(this).prop("checked", true)) {
					for (var i=0; i < lineup.length; i++) {
					if (!! lineup[i].sub) { //string
						if (lineup[i] == $(this).attr('data-fullname')) {
						lineup[i] = {base: $(this).attr('data-fullname'), alignment: $(this).attr('value'), name: $(this).attr('data-fullname')}
					}} else { // dict.
						if (lineup[i]['name'] == $(this).attr('data-fullname')) {
							lineup[i]['alignment'] = $(this).attr('value');
						}
					}
				}
				}
		update_lineup();
		});



		});
}

function update_lineup() {
	fix_doubles();
	var proportions = {};
	$.ajax({
            url: "lineup",
            type: 'POST',
            dataType: 'json',
            data: JSON.stringify(lineup),
            success: give_lineup_results,
            error: function() {
                $("#status").html('<div class="alert alert-danger" role="alert"><i class="far fa-skull-crossbones"></i> Oh Snap. Nothing back.</div>');
            }
        });



}

window.lineup=[];
$( document ).ready(initial);

