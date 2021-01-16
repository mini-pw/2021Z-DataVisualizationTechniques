import dash
import dash_core_components as dcc
import dash_html_components as html
import pandas as pd
import plotly.express as px
from dash.dependencies import Input, Output

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

kacper = pd.read_csv("../kacper.csv")
kacperCount = pd.read_csv("../kacperCount.csv")
jakub = pd.read_csv("../jakub.csv")
jakubCount = pd.read_csv("../jakubCount.csv")
jan = pd.read_csv("../jan.csv")
janCount = pd.read_csv("../janCount.csv")

allCount = pd.read_csv("../allCount.csv")


DOMAINS = {"Stackoverflow": "stackoverflow.com",
           "Wikipedia": "wikipedia.org",
           "GitHub": "github.com",
           "Politechnika Warszawska": "pw.edu.pl",
           "Youtube": "youtube.com",
           "Google": "google.com",
           "Facebook": "facebook.com",
           "Instagram": "instagram.com"}


def to_dashformat(mapa: dict):
    out = []
    for key in mapa:
        out.append({"label": key, "value": mapa[key]})
    return out


@app.callback(
    Output("TotalLineplot", "figure"),
    Input("totalPlotDomainSelect", "value")
)
def make_totalplot(selected_domain: str):
    print("kurea")
    total_df = allCount[allCount["domain"] == selected_domain]
    total_df = total_df.groupby(["date", "user"]).sum()
    # total_df["count"] = total_df["count"].rolling(14, min_periods=1).mean()
    total_df = total_df.reset_index()
    return px.line(total_df, x="date", y="count", color="user")


initTotalplot = make_totalplot("pw.edu.pl")


def make_perplot():
    pass


app.layout = html.Div([
    dcc.Markdown(children="# TWD projekt 3 dashboard"),

    dcc.Markdown(children="## Total usage over time"),
    dcc.Graph(
        id="TotalLineplot",
        figure=initTotalplot
    ),
    html.Label("Choose which sites to sum"),
    dcc.Dropdown(
        options=[
            {'label': 'New York City', 'value': 'NYC'},
            {'label': u'Montréal', 'value': 'MTL'},
            {'label': 'San Francisco', 'value': 'SF'}
        ],
        value='MTL'
    ),

    dcc.Markdown(children="## Per weekday/hour usage"),
    html.Div([
        html.Br(),
        dcc.Graph(
            id="PerDayBarplot",
            figure=px.histogram(kacper, x="domain")  # todo: wygenerować plot
        ),
        dcc.RadioItems(
            id="UserSelect",
            options=[
                {"label": "Jakub", "value": "user1"},
                {"label": "Jan", "value": "user2"},
                {"label": "Kacper", "value": "user3"}
            ]
        )
    ]),

    # zostawiam ten bałagan na razie
    html.Label('Domeny'),
    dcc.Checklist(
        id="domain-select",
        options=to_dashformat(DOMAINS),
        value=["stackoverflow.com", "wikipedia.org", "github.com"]
    ),
    dcc.Graph(
        id="histogram",
        figure=px.histogram(kacper, x="domain")
    )
])


@app.callback(
    Output("histogram", "figure"),
    Input('domain-select', 'value')
)
def update_figure(selected):
    df_filter = kacper[kacper["domain"].isin(selected)]
    return px.histogram(df_filter, x="domain")


if __name__ == '__main__':
    app.run_server(debug=True)
