//The Radar Chart Function based on Nadieh Bremer, http://bl.ocks.org/nbremer/21746a9668ffdf6d8242
var margin3 = { top: 100, right: 100, bottom: 100, left: 100 },
	width3 = Math.min(700, window.innerWidth - 10),
	height3 = Math.min(width3, window.innerHeight);


function RadarChart() {
	var cfg = {
		margin: { top: 100, right: 100, bottom: 100, left: 100 }, //The margins of the SVG
		w: Math.min(700, window.innerWidth - 10) - margin3.left - margin3.right,				//Width of the circle
		h: Math.min(width3, window.innerHeight - margin3.top - margin3.bottom - 20),				//Height of the circle
		levels: 7,				//How many levels or inner circles should there be drawn
		maxValue: 0.7, 			//What is the value that the biggest circle will represent
		labelFactor: 1.2, 	//How much farther than the radius of the outer circle should the labels be placed
		wrapWidth: 60, 		//The number of pixels after which a label needs to be given a new line
		opacityArea: 0.35, 	//The opacity of the area of the blob
		dotRadius: 4, 			//The size of the colored circles of each blog
		opacityCircles: 0.1, 	//The opacity of the circles of each blob
		strokeWidth: 2, 		//The width of the stroke around each blob
		roundStrokes: true,	//If true the area and stroke will follow a round path (cardinal-closed)
		color: d3.scaleOrdinal().range(["#eb8ea3", "#06D6A0", "#118AB2"])	//Color function
	};

	var data3 = [
		[//p
			{ axis: "danceability", value: 0.578 },
			{ axis: "energy", value: 0.648 },
			{ axis: "acousticness", value: 0.320 },
			{ axis: "instrumentalness", value: 0.038 },
			{ axis: "liveness", value: 0.236 },
			{ axis: "valence", value: 0.403 }
		], [//u
			{ axis: "danceability", value: 0.529 },
			{ axis: "energy", value: 0.439 },
			{ axis: "acousticness", value: 0.596 },
			{ axis: "instrumentalness", value: 0.083 },
			{ axis: "liveness", value: 0.144 },
			{ axis: "valence", value: 0.337 }
		], [//z
			{ axis: "danceability", value: 0.478 },
			{ axis: "energy", value: 0.667 },
			{ axis: "acousticness", value: 0.195 },
			{ axis: "instrumentalness", value: 0.463 },
			{ axis: "liveness", value: 0.218 },
			{ axis: "valence", value: 0.389 }
		]
	];

	var maxValue = cfg.maxValue;

	var allAxis = (data3[0].map(function (i, j) { return i.axis })),	//Names of each axis
		total = allAxis.length,					//The number of different axes
		radius = Math.min(cfg.w / 2, cfg.h / 2), 	//Radius of the outermost circle
		angleSlice = Math.PI * 2 / total;		//The width in radians of each "slice"

	//Scale for the radius
	var rScale = d3.scaleLinear()
		.range([0, radius])
		.domain([0, maxValue]);


	// Create the container SVG and g


	//Initiate the radar chart SVG
	var svg = d3.select("#div3").append("svg")
		.attr("width", cfg.w + cfg.margin.left + cfg.margin.right)
		.attr("height", cfg.h + cfg.margin.top + cfg.margin.bottom)
	//.attr("class", "radar"+".radarChart");
	//Append a g element
	var g = svg.append("g")
		.attr("transform", "translate(" + (cfg.w / 2 + cfg.margin.left) + "," + (cfg.h / 2 + cfg.margin.top) + ")");


	// Glow filter for some extra pizzazz
	//Filter for the outside glow
	var filter = g.append('defs').append('filter').attr('id', 'glow'),
		feGaussianBlur = filter.append('feGaussianBlur').attr('stdDeviation', '2.5').attr('result', 'coloredBlur'),
		feMerge = filter.append('feMerge'),
		feMergeNode_1 = feMerge.append('feMergeNode').attr('in', 'coloredBlur'),
		feMergeNode_2 = feMerge.append('feMergeNode').attr('in', 'SourceGraphic');


	// Draw the Circular grid
	//Wrapper for the grid & axes
	var axisGrid = g.append("g").attr("class", "axisWrapper");

	//Draw the background circles
	axisGrid.selectAll(".levels")
		.data(d3.range(1, (cfg.levels + 1)).reverse())
		.enter()
		.append("circle")
		.attr("class", "gridCircle")
		.attr("r", function (d, i) { return radius / cfg.levels * d; })
		.style("fill", "#CDCDCD")
		.style("stroke", "#CDCDCD")
		.style("fill-opacity", cfg.opacityCircles)
		.style("filter", "url(#glow)");

	//Text indicating at what % each level is
	axisGrid.selectAll(".axisLabel")
		.data(d3.range(1, (cfg.levels + 1)).reverse())
		.enter().append("text")
		.attr("class", "axisLabel")
		.attr("x", 4)
		.attr("y", function (d) { return -d * radius / cfg.levels; })
		.attr("dy", "0.4em")
		.style("font-size", "10px")
		.attr("fill", "#737373")
		.text(function (d, i) { return (maxValue * d / cfg.levels).toFixed(1); });


	// Draw the axes
	//Create the straight lines radiating outward from the center
	var axis = axisGrid.selectAll(".axis")
		.data(allAxis)
		.enter()
		.append("g")
		.attr("class", "axis");
	//Append the lines
	axis.append("line")
		.attr("x1", 0)
		.attr("y1", 0)
		.attr("x2", function (d, i) { return rScale(maxValue * 1.1) * Math.cos(angleSlice * i - Math.PI / 2); })
		.attr("y2", function (d, i) { return rScale(maxValue * 1.1) * Math.sin(angleSlice * i - Math.PI / 2); })
		.attr("class", "line")
		.style("stroke", "white")
		.style("stroke-width", "2px");

	//Append the labels at each axis
	axis.append("text")
		.attr("class", "legend")
		.style("font-size", "14px")
		.attr("text-anchor", "middle")
		.attr("dy", "0.35em")
		.attr("x", function (d, i) { return rScale(maxValue * cfg.labelFactor) * Math.cos(angleSlice * i - Math.PI / 2); })
		.attr("y", function (d, i) { return rScale(maxValue * cfg.labelFactor) * Math.sin(angleSlice * i - Math.PI / 2); })
		.text(function (d) { return d });


	// Draw the radar chart blobs
	//The radial line function
	var radarLine = d3.lineRadial()
		.curve(d3.curveLinearClosed)
		.radius(function (d) { return rScale(d.value); })
		.angle(function (d, i) { return i * angleSlice; });

	if (cfg.roundStrokes) {
		radarLine.curve(d3.curveCardinalClosed);
	}

	//Create a wrapper for the blobs
	var blobWrapper = g.selectAll(".radarWrapper")
		.data(data3)
		.enter().append("g")
		.attr("class", "radarWrapper");

	//Append the backgrounds
	blobWrapper
		.append("path")
		.attr("class", "radarArea")
		.attr("d", function (d, i) { return radarLine(d); })
		.style("fill", function (d, i) { return cfg.color(i); })
		.style("fill-opacity", cfg.opacityArea)
		.on('mouseover', function (d, i) {
			//Dim all blobs
			d3.selectAll(".radarArea")
				.transition().duration(200)
				.style("fill-opacity", 0.1);
			//Bring back the hovered over blob
			d3.select(this)
				.transition().duration(200)
				.style("fill-opacity", 0.7);
		})
		.on('mouseout', function () {
			//Bring back all blobs
			d3.selectAll(".radarArea")
				.transition().duration(200)
				.style("fill-opacity", cfg.opacityArea);
		});

	//Create the outlines
	blobWrapper.append("path")
		.attr("class", "radarStroke")
		.attr("d", function (d, i) { return radarLine(d); })
		.style("stroke-width", cfg.strokeWidth + "px")
		.style("stroke", function (d, i) { return cfg.color(i); })
		.style("fill", "none")
		.style("filter", "url(#glow)");

	//Append the circles
	blobWrapper.selectAll(".radarCircle")
		.data(function (d, i) {
			return d.map((e) => [e, i]);
		})
		.enter().append("circle")
		.attr("class", "radarCircle")
		.attr("r", cfg.dotRadius)
		.attr("cx", function (d, i) {
			d = d[0]
			return rScale(d.value) * Math.cos(angleSlice * i - Math.PI / 2);
		})
		.attr("cy", function (d, i) {
			d = d[0]
			return rScale(d.value) * Math.sin(angleSlice * i - Math.PI / 2);
		})
		.style("fill", function (d, i, j) { return cfg.color(d[1]); })
		.style("fill-opacity", 0.8);


	// Append invisible circles for tooltip
	//Wrapper for the invisible circles on top
	var blobCircleWrapper = g.selectAll(".radarCircleWrapper")
		.data(data3)
		.enter().append("g")
		.attr("class", "radarCircleWrapper");

	//Append a set of invisible circles on top for the mouseover pop-up
	blobCircleWrapper.selectAll(".radarInvisibleCircle")
		.data(function (d, i) { return d; })
		.enter().append("circle")
		.attr("class", "radarInvisibleCircle")
		.attr("r", cfg.dotRadius * 1.5)
		.attr("cx", function (d, i) { return rScale(d.value) * Math.cos(angleSlice * i - Math.PI / 2); })
		.attr("cy", function (d, i) { return rScale(d.value) * Math.sin(angleSlice * i - Math.PI / 2); })
		.style("fill", "none")
		.style("pointer-events", "all")
		.on("mouseover", function (event, d, value) {
			newX = parseFloat(d3.select(this).attr('cx')) - 10;
			newY = parseFloat(d3.select(this).attr('cy')) - 10;

			tooltip
				.attr('x', newX)
				.attr('y', newY)
				.text(d.value.toFixed(2))
				.transition().duration(200)
				.style('opacity', 1);
		})
		.on("mouseout", function () {
			tooltip.transition().duration(200)
				.style("opacity", 0);
		});

	//Set up the small tooltip for when you hover over a circle
	var tooltip = g.append("text")
		.attr("class", "tooltip")
		.style("opacity", 0);
} RadarChart();
