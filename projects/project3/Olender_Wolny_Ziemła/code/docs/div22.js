var _d22create = true;
var d22x;
var d22y;
function scrollAndShowTrack(trackid) {
    d3.select("#singleInfo").node().scrollIntoView({ block: 'nearest', behavior: 'smooth' })
    showTrack(trackid)
}

function updateScatter() {
    var margin = { top: 10, right: 30, bottom: 30, left: 120 },
        width = 1300 - margin.left - margin.right,
        height = 1000 - margin.top - margin.bottom;

    if (_d22create) {
        scatter = d3.select("#d22scatter")
        d22svg = scatter
            .append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform",
                "translate(" + margin.left + "," + margin.top + ")");
    }

    xval = d3.select("#d22xval").node().value
    yval = d3.select("#d22yval").node().value
    xvalname = xval
    yvalname = yval

    data = dataArray.filter((el) => (!isNaN(el[xval] && !isNaN(el[yval]))))
    if (yval == "duration") {
        yval = "duration_ms"
        data = data.map((track) => {
            return [track,
                track[xval],
                track[yval] / 1000]
        })
    }
    else if (xval == "duration") {
        xval = "duration_ms"
        data = data.map((track) => {
            return [track,
                track[xval] / 1000,
                track[yval]]
        })

    }
    else {
        data = data.map((track) => {
            return [track,
                track[xval],
                track[yval]]
        })
    }


    xs = data.map((t) => t[1])
    ys = data.map((t) => t[2])
    function padDomain(ax) {
        min = Math.min(...ax)
        max = Math.max(...ax)
        spread = Math.abs(min - max) * 0.1
        return [min - spread, max + spread]
    }

    // Add dots

    d22x = d3.scaleLinear()
        .domain(padDomain(xs))
        .range([0, width]);

    d22y = d3.scaleLinear()
        .domain(padDomain(ys))
        .range([height, 0]);

    size = 60


    if (_d22create) {

        d22svg.append("g")
            .attr("id", "d22xaxis")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(d22x));


        d22svg.append("g")
            .attr("id", "d22yaxis")
            .call(d3.axisLeft(d22y));

        d22svg.selectAll("defs")
            .data(data)
            .enter()
            .append("clipPath")
            .attr("id", (d) => ("scatterCircle" + d[0].id))
            .append("circle")
            .transition()
            .duration(500)
            .attr("cx", (d) => (d22x(d[1]) + size / 2))
            .attr("cy", (d) => (d22y(d[2]) + size / 2))
            .attr("r", size / 2)

        var dots = d22svg.selectAll('g')
            .data(data)
            .enter()
            .append("g")

        var div = d3.select("#d22scatter").append("div")
            .attr("class", "tooltip")
            .style("opacity", 0);


        d22svg.data(data).enter()
        var tmp = dots.append("d22svg:image")
            .attr("xlink:href", function (d) { return d[0]["img"] })
            .attr("onclick", d => 'scrollAndShowTrack("' + d[0].id + '")')
            .attr("height", size)
            .attr("name", (d) => d["title"])
            .attr("clip-path", d => "url(#scatterCircle" + d[0].id + ")")
            .attr("width", size)
            .on("mouseover", function (event, d) {
                div.transition()
                    .duration(200)
                    .style("opacity", .9);
                div.html("<b>" + d[0]["name"] + "</b><br/>" +
                    capitalize(xvalname) + ": " + d[1] + "</br > " +
                    capitalize(yvalname) + ": " + d[2] + "</br > ")
                    .style("left", (event.pageX) + "px")
                    .style("top", (event.pageY - 28) + "px");
            })
            .on("mouseout", function (d) {
                div.transition()
                    .duration(500)
                    .style("opacity", 0);
            })
        tmp.transition()
            .duration(500)
            .attr("x", function (d) {
                return d22x(d[1])
            })
            .attr("y", function (d) {
                return d22y(d[2])
            })
        // tmp.append("title").html(function (d) { return d[0]["author"] + " - " + d[0]["name"] })
        _d22create = false
        updateScatter();
    }
    d22svg.select("#d22xaxis")
        .transition()
        .duration(500)
        .attr("opacity", "1")
        .call(d3.axisBottom(d22x))
    d22svg.select("#d22yaxis")
        .transition()
        .duration(500)
        .attr("opacity", "1")
        .call(d3.axisLeft(d22y))

    data.forEach(d => {
        d22svg.selectAll("#scatterCircle" + d[0].id)
            .selectAll("circle")
            .transition()
            .duration(500)
            .attr("cx", d22x(d[1]) + size / 2)
            .attr("cy", d22y(d[2]) + size / 2)
            .attr("r", size / 2)

    });


    d22svg.selectAll("image")
        .attr("xlink:href", function (d) { return d[0]["img"] })
        .attr("onclick", d => 'scrollAndShowTrack("' + d[0].id + '")')
        .attr("name", (d) => d["title"])
        .attr("clip-path", d => "url(#scatterCircle" + d[0].id + ")")
        .data(data)
        .transition()
        .duration(500)
        .attr("x", function (d) {
            return d22x(d[1])
        })
        .attr("y", function (d) {
            return d22y(d[2])
        })
    _d22create = false
}

