var dataset = [];
var freq = [];
var usr;
var chart1;
var chart2;
var freqs;

function createActivityBar(dataset){
	var n = document.getElementById("showRange").value;
	var names = []
	var time = []
	var colors = [] // ik, wierd
	for(var i = 0; i < n; i++){
		names.push(dataset[i].Vidname);
		time.push(dataset[i].Total);
		colors.push("#FF0000");
	}
    var options = {
      legend: { 
      	display:false
      },
      title: {
        display: true,
        text: 'Najpopularniejsze wśród oglądanych',
        fontColor: 'white'
      },
       scales: {
        yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]
    }
    };
	var data = {
      labels: names,
      fontColor: 'white',
      datasets: [
        {
          label: "Najpopularniejsze wśród oglądanych",
          backgroundColor: colors,
          data: time,
        }
      ]
    };

    var canv = document.getElementById("popularity");
    var ctx = canv.getContext("2d");
    ctx.clearRect(0, 0, canv.width, canv.height);
    ctx.beginPath();
    if(chart1 != undefined){
    	chart1 && chart1.destroy();
    }
    chart1 = new Chart(ctx, {
    type: 'bar',
    data: data,
    options: options
});

}


function createTimeBar(freq){
	var colors = []
	var lab = [];
	for(var i = 0; i < freq.length; i++){
		colors.push("#FF0000");
		var to_push;
		if(i % 6 == 0){
			to_push = `${i/6}:00`;
		}else{
			to_push = "";
		}
		lab.push(to_push);
	}
    var options = {
      legend: { display: false },
      title: {
        display: true,
        text: "Rozkład pór oglądania",
        fontColor: 'white'
      },
       scales: {
        yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]
    }
    };
	var data = {
	  labels:lab,
      datasets: [
        {
          label: "Rozkład pór oglądania",
          backgroundColor: colors,
          data: freq
        }
      ]
    };

    var canv = document.getElementById("time");
    var ctx = canv.getContext("2d");
    ctx.clearRect(0, 0, canv.width, canv.height);
    ctx.beginPath();
    if(chart2 != undefined){
    	chart2 && chart2.destroy();
    }
    chart2 = new Chart(ctx, {
    type: 'bar',
    data: data,
    options: options
});

}



function setUserDisplay(arg){
	makePop(arg);
	makeHist(arg);
}

function makePop(arg){
	dataset = [];
	usr = arg;
	var myactivitydata = d3.csv(`Activity${arg}.csv`, function(data){
		if(data.Username == arg){
			dataset.push(data);
		}
		return data;
});
	setTimeout(function(){
	createActivityBar(dataset);
	},200);	

}

function readTextFile(file)
{
    var rawFile = new XMLHttpRequest();
    rawFile.open("GET", file, false);
    rawFile.onreadystatechange = function ()
    {
        if(rawFile.readyState === 4)
        {
            if(rawFile.status === 200 || rawFile.status == 0)
            {
                freqs = rawFile.responseText;
            }
        }
    }
    rawFile.send(null);
}

function makeHist(arg){
	readTextFile(`fileFrequency${arg}`);
	usr = arg;
	var freqs2 = freqs.split("\n");
	var dfreq = [];
	for(var i = 0; i < freqs2.length; i++){
		dfreq.push(parseFloat(freqs2[i]));
	}
	createTimeBar(dfreq);
}

function onBarChange(){
	if(usr != undefined){
		setUserDisplay(usr);
	}
}



function main(){


}