
function capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1)
}

dataArray = []
var vals = ["danceability", "energy", "loudness", "speechiness", "acousticness", "instrumentalness", "liveness", "valence", "tempo", "duration_ms"];

d3.csv("data.csv", function (track) {
    dataArray.push(track)
    box = d3.select("#div1")
    box.select("#div1" + track["whose"])
        .append("img")
        .attr("id", "id" + track["id"])
        .attr("onclick", 'scrollAndShowTrack("' + track.id + '")')
        .attr("class", "track")
        .attr("title", track["name"])
        .attr("src", track["img"])
        .attr("alt", track["name"]);
}).then(() => {
    showTrack(dataArray[0].id)
    ticks2("null")
    updateScatter()
})

var prevId = null
function showTrack(trackid) {
    track = dataArray.find((track) => track.id === trackid)
    d3.selectAll("#id" + prevId).attr("class", "track")
    d3.selectAll('#id' + trackid).attr("class", "track selectedTrack")
    var box = d3.select("#singleInfo")
    box.selectAll("*").remove()

    var img = box.append("a").attr("href", track["link"]).append("img").attr("src", track["img"]).attr("style", "border-radius:4px;")
    box.append("div").attr("class", "spacer2")

    tbl = box.append("div").attr("id", "sITable")


    row = tbl.append("tr").attr("style", "width:70%;")
    row.append("th").text(track.name).attr("style", "text-align:left;color:black;")
    row = tbl.append("tr").attr("style", "width:70%;")
    row.append("th").text(track.author).attr("style", "text-align:left;color:black;")
    row = tbl.append("tr").attr("style", "width:70%;")
    row.append("td").text("Album")
    row.append("td").text(track.album).attr("style", "text-align:right;")
    vals.forEach(val => {
        row = tbl.append("tr").attr("style", "width:70%;")
        var s = capitalize(val)
        var v = track[val]
        if (s == "Duration_ms") {
            s = "Duration (s)"
            v = v / 1000
        }
        row.append("td").text(s)
        row.append("td").text(v).attr("style", "text-align:right;")
    });
    prevId = trackid;
}