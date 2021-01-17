var margin = { top: 30, right: 30, bottom: 40, left: 50 },
    width = 460 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;



var selected = []
function ticks2(str) {
    var checked = [];
    d3.selectAll(".tickbox").selectAll("input").each(function (e) {
        checked.push(this.checked);
    })

    selected = []
    for (let i = 0; i < checked.length; i++) {
        if (checked[i]) {
            selected.push(vals[i]);
        };
    }
    // redraw
    drawPlot()
    n = d3.select("#chart" + str).node();
    if (n === null) {
        return;
    }
    n.scrollIntoView({ block: 'nearest', behavior: 'smooth' })
}

function drawPlot() {
    vals.forEach(val => {
        if (!selected.includes(val)) {
            d3.select("#chart" + val).remove()
        }
    });



    selected.forEach(sel => {
        if (!d3.select("#chart" + sel).empty()) { return }

        chartvals = dataArray.map((el) => el[sel]);

        var svg = d3.select("#distributions")
            .append("svg")
            .attr("id", "chart" + sel)
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform",
                "translate(" + margin.left + "," + margin.top + ")");

        if (sel == "duration_ms") {

            chartvals = chartvals.map((e) => e / 1000)
        }


        xmin = Math.min(...chartvals)
        xmax = Math.max(...chartvals)
        var x = d3.scaleLinear()
            .domain([xmin, xmax])     // can use this instead of 1000 to have the max of data: d3.max(data, function(d) { return +d.price })
            .range([0, width]);
        svg.append("g")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(x));

        // set the parameters for the histogram
        var histogram = d3.histogram()
            .value(function (d) { return d })   // I need to give the vector of value
            .domain(x.domain())  // then the domain of the graphic
            .thresholds(x.ticks(24)); // then the numbers of bins

        // And apply this function to data to get the bins
        function norm(ys) {
            one = ys.map((e) => e[1]).reduce((a, b) => a + b)
            ys = ys.map((e) => [e[0], e[1] / one])
            return ys
        }
        function whoseBins(str) {
            if (str === "puv") {
                d = dataArray
            }
            else {
                d = dataArray.filter((el) => el["whose"] == str)
            }
            d = d.map((el) => el[sel]);
            if (sel == "duration_ms") {

                d = d.map((e) => e / 1000)
            }
            a = []
            a.x0 = Math.min(...d)
            var bins = [a]
            bins = bins.concat(histogram(d));
            b = []
            b.x0 = Math.max(...d)
            bins = bins.concat([b])
            bins = (bins.map((el) => [el.x0, el.length]))
            return norm(bins)
        }

        binp = whoseBins("p")
        binu = whoseBins("u")
        binz = whoseBins("z")
        maxx = Math.max(...binp.map((e) => e[1]))
        maxx = Math.max(maxx, ...binu.map((e) => e[1]))
        maxx = Math.max(maxx, ...binz.map((e) => e[1]))
        // Y axis: scale and draw:
        var y = d3.scaleLinear()
            .range([height, 0]);
        y.domain([0, maxx * 1.1]);   // d3.hist has to be called before the Y axis obviously
        svg.append("g")
            .call(d3.axisLeft(y));

        // append the bar rectangles to the svg element
        svg.append("path")
            .attr("class", "mypath")
            .datum(whoseBins("p"))
            .attr("fill", "#eb8ea3")
            .attr("opacity", ".5")
            .attr("stroke", "#000")
            .attr("stroke-width", 1)
            .attr("stroke-linejoin", "round")
            .attr("d", d3.line()
                .curve(d3.curveBasis)
                .x(function (d) { return x(d[0]); })
                .y(function (d) { return y(d[1]); })
            );

        svg.append("path")
            .attr("class", "mypath")
            .datum(whoseBins("u"))
            .attr("fill", "#06D6A0")
            .attr("opacity", ".5")
            .attr("stroke", "#000")
            .attr("stroke-width", 1)
            .attr("stroke-linejoin", "round")
            .attr("d", d3.line()
                .curve(d3.curveBasis)
                .x(function (d) { return x(d[0]); })
                .y(function (d) { return y(d[1]); })
            );

        svg.append("path")
            .attr("class", "mypath")
            .datum(whoseBins("z"))
            .attr("fill", "#118AB2")
            .attr("opacity", ".5")
            .attr("stroke", "#000")
            .attr("stroke-width", 1)
            .attr("stroke-linejoin", "round")
            .attr("d", d3.line()
                .curve(d3.curveBasis)
                .x(function (d) { return x(d[0]); })
                .y(function (d) { return y(d[1]); })
            );


        sel = sel == "duration_ms" ? "duration (seconds)" : sel;
        svg.append("text")
            .attr("x", width / 2)
            .attr("y", height + margin.bottom - 10)
            .style("text-anchor", "middle")
            .text("Distribution of " + sel)


    });
}


// Function to compute density
function kernelDensityEstimator(kernel, X) {
    return function (V) {
        return X.map(function (x) {
            return [x, d3.mean(V, function (v) { return kernel(x - v); })];
        });
    };
}
function kernelEpanechnikov(k) {
    return function (v) {
        return Math.abs(v /= k) <= 1 ? 0.75 * (1 - v * v) / k : 0;
    };
}
