

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

function duel_t() {
	$.ajax({
  method: "POST",
  url: "",
  data: []
})
  .done(function( msg ) {
    alert( "Data Saved: " + msg );
  });
	}


function Output (text) {
	flip("result",0);
	$("#OUT_battles").html("");
	$("#OUT_rounds").html("");
	$("#OUT_prediction").html("");
	$("#OUT_notes").html("");
	$("#OUT_team").html("");
	$("#OUT_combattant").html("");
	$("#status").html("Calculations complete");
		console.log(text);
    reply=JSON.parse(text);
	
	header={notes: "Notes",
		rounds:"Total number of rounds fought",
		battles:"Total number of battles fought" ,
		prediction:"Rought predictions",
		}
	for (k in header) {
		console.log("#OUT_"+	k)
	$("#OUT_"+	k).html(header[k]+": "+reply[k]);
		}
	tmax=100/4;
	t="<table class=res><thead><tr>"+
	"<th width='"+ tmax +"%'>Team name</th>"+
	"<th width='"+ tmax +"%'>Number of victories</th>"+
	"<th width='"+ tmax +"%'>Number of close calls</th>"+
	"<th width='"+ tmax +"%'>Number of perfects</th>"+"</tr></thead><tbody>";
	for (ti=0; ti<reply["team_names"].length; ti++) {
		t+="<tr><th width='"+ tmax +" %'>"+reply["team_names"][ti]+"</th><td width='"+tmax+"%'>"+
		reply["team_victories"][ti]+"</td><td width='"+tmax+"%'>"+
		reply["team_close"][ti]+"</td><td width='"+tmax+"%'>"+
		reply["team_perfects"][ti]+"</td>"+"</tr>";
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
	for (ci=0; ci<reply["combattant_names"].length; ci++) {
		c+="<tr><th width='"+ cmax +" %'>"+reply["combattant_names"][ci]+"</th><td width='"+ cmax +" %'>"+
		reply["combattant_alignments"][ci]+"</td><td width='"+ cmax +" %'>"+
		parseFloat(reply["combattant_damage_avg"][ci]).toFixed(2)+"</td><td width='"+ cmax +" %'>"+
		parseFloat(reply["combattant_hit_avg"][ci]).toFixed(2)+"</td><td width='"+ cmax +" %'>"+
		parseFloat(reply["combattant_miss_avg"][ci]).toFixed(2)+"</td><td width='"+ cmax +" %'>"+
		parseFloat(reply["combattant_rounds"][ci]).toFixed(2)+"</td>"+
		"</tr>";
		}
	c+="</table>";
    $("#OUT_combattant").html(c);
	$("#OUT_sample").html(reply['sample_encounter']);
	}

function duel() {
console.log(sessionStorage.getItem('lineup'));
flip("result",1)
document.getElementById("status").innerHTML="<i class='fa fa-spinner fa-pulse'></i> Simulation in progress.";
xmlhttp=new XMLHttpRequest();
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {Output(xmlhttp.responseText);}
  }
xmlhttp.open("POST","wsgi.py",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send(sessionStorage.getItem('lineup'));
}

function Add(newbie) {
	var lineup=JSON.parse(sessionStorage.getItem('lineup'));
	lineup.push(newbie);
	sessionStorage.setItem('lineup', JSON.stringify(lineup));
	$("#lineup").html(JSON.stringify(lineup));
	}

function AddA() {
	var newbie=$("#drop").val();
	Add(newbie);
	$("#confA").show("slow");
	$("#confA").hide("slow");
	}

function AddB() {
	try{
	newbie=JSON.parse($("#def").val());
	if( typeof newbie === 'string' ) {
		newbie=[newbie];
		console.log('Converted string to array');
		console.log(newbie);
		}
	}
	catch(err){
		console.log("ISSUE WITH INPUT");
		console.log($("#def").val());
		$("#failB").show("slow");
		$("#failB").hide("slow");
		return 0
	}
	
	var lineup=JSON.parse(sessionStorage.getItem('lineup'))
	
	try {
	var lineplus=JSON.stringify(lineup.concat(newbie));
	sessionStorage.setItem('lineup', lineplus);
	} catch (err) {
		console.log("ISSUE ADDING INPUT TO JSON");
		console.log($("#def").val());
		$("#failB").show("slow");
		$("#failB").hide("slow");
		return 0
		}
	
	$("#lineup").html(lineplus);
	$("#confB").show("slow");
	$("#def").val("");
	$("#confB").hide("slow");
	}
	
function AddC() {
		var newbie={};
	$("#table").find('input').each(function(index, element) {
        key=$(this).attr('id');
		var v=$("#"+key).val();
		if (!!v) {newbie[key]=$("#"+key).val();}
			$("#"+key).val("");
    });
	Add(newbie);
	$("#confC").show("slow");
	$("#confC").hide("slow");
	}
	
function initial() {
	$("#def").keyup(function(event){if(event.keyCode == 13){AddB();}});
	$("#confA").hide();
	$("#confB").hide();
	$("#confC").hide();
	$("#failB").hide();
	sessionStorage.setItem('lineup', JSON.stringify([]));
	$("#OFF_more").hide();
	$("#OFF_work").hide();
	$("#OFF_link").hide();
	$("#OFF_motive").hide();
	$("#OFF_future").hide();
	$("#OFF_setup").hide();
	$("#ON_result").hide();
	$("#DIV_result").hide();
	$("#OUT_sample").hide();
	}
	
$( document ).ready(initial) 

