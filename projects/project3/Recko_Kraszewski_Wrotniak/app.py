import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_bootstrap_components as dbc
import plotly.express as px
import pandas as pd
import datetime
from datetime import date
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import numpy as np

external_stylesheets = [dbc.themes.LUMEN]
Szymon = pd.read_csv("Szymon.csv")
Konstanty = pd.read_csv("Konstanty.csv")
Krystian = pd.read_csv("Krystian.csv")

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

Szymon["watchedTIME"] = Szymon.apply(lambda row: str(datetime.timedelta(seconds=row["watched"] // 1000)), axis=1)
Szymon["openedTIME"] = Szymon.apply(lambda row: str(datetime.timedelta(seconds=row["opened"]) // 1000), axis=1)
Szymon["ratio"] = Szymon.apply(lambda row: row["watched"] / row["opened"] if row["opened"] != 0 else 0, axis=1)

Konstanty["watchedTIME"] = Konstanty.apply(lambda row: str(datetime.timedelta(seconds=row["watched"] // 1000)), axis=1)
Konstanty["openedTIME"] = Konstanty.apply(lambda row: str(datetime.timedelta(seconds=row["opened"]) // 1000), axis=1)
Konstanty["ratio"] = Konstanty.apply(lambda row: row["watched"] / row["opened"] if row["opened"] != 0 else 0, axis=1)

Krystian["watchedTIME"] = Krystian.apply(lambda row: str(datetime.timedelta(seconds=row["watched"] // 1000)), axis=1)
Krystian["openedTIME"] = Krystian.apply(lambda row: str(datetime.timedelta(seconds=row["opened"]) // 1000), axis=1)
Krystian["ratio"] = Krystian.apply(lambda row: row["watched"] / row["opened"] if row["opened"] != 0 else 0, axis=1)

summedup = pd.DataFrame(columns=["date", "opened", "watched", "count"])
summedup["date"] = Szymon["date"]
summedup["opened"] = Szymon["opened"] + Krystian["opened"] + Konstanty["opened"]
summedup["watched"] = Szymon["watched"] + Krystian["watched"] + Konstanty["watched"]
summedup["count"] = Szymon["count"] + Krystian["count"] + Konstanty["count"]

summedup["watchedTIME"] = summedup.apply(lambda row: str(datetime.timedelta(seconds=row["watched"] // 1000)), axis=1)
summedup["openedTIME"] = summedup.apply(lambda row: str(datetime.timedelta(seconds=row["opened"]) // 1000), axis=1)
summedup["ratio"] = summedup.apply(lambda row: row["watched"] / row["opened"] if row["opened"] != 0 else 0, axis=1)

CARD_TEXT_STYLE = {
    'textAlign': 'center',
    'color': '#000000'
}
first_row2 = first_row = dbc.Row([
    dbc.Col(
        dbc.Card(
            [

                dbc.CardBody(
                    [
                        html.H3(id='card_Szymon', children=['Szymon'], className='card-title',
                                style=CARD_TEXT_STYLE),
                        html.H4(id='card_text_Szymon', children=['Place Holder'], style=CARD_TEXT_STYLE),
                    ],

                )
            ]
        ), md=3
    ),
    dbc.Col(
        dbc.Card(
            [

                dbc.CardBody(
                    [
                        html.H3(id='card_Krystian', children=['Krystian'], className='card-title',
                                style=CARD_TEXT_STYLE),
                        html.H4(id='card_text_Krystian', children=['Place Holder'], style=CARD_TEXT_STYLE),
                    ],

                )
            ]
        ), md=3
    ),
    dbc.Col(
        dbc.Card(
            [

                dbc.CardBody(
                    [
                        html.H3(id='card_Konstanty', children=['Konstanty'], className='card-title',
                                style=CARD_TEXT_STYLE),
                        html.H4(id='card_text_Konstanty', children=['Place Holder'], style=CARD_TEXT_STYLE),
                    ],

                )
            ]
        ), md=3
    )
], justify="center")

first_row = dbc.Row([
    dbc.Col(
        dbc.Card(
            [

                dbc.CardBody(
                    [
                        html.H3(id='card_title_1', children=['Watched'], className='card-title',
                                style=CARD_TEXT_STYLE),
                        html.H4(id='card_text_1', children=['Place Holder'], style=CARD_TEXT_STYLE),
                        html.H6(id='card_info_1', children=["The real time you spent watching videos."],
                                style=CARD_TEXT_STYLE),
                    ],

                )
            ]
        ), md=3
    ),
    dbc.Col(
        dbc.Card(
            [

                dbc.CardBody(
                    [
                        html.H3(id='card_title_2', children=['Opened'], className='card-title',
                                style=CARD_TEXT_STYLE),
                        html.H4(id='card_text_2', children=['Place Holder'], style=CARD_TEXT_STYLE),
                        html.H6(id='card_info_2', children=["The total time of the videos."], style=CARD_TEXT_STYLE),
                    ],

                )
            ]
        ), md=3
    ),
    dbc.Col(
        dbc.Card(
            [

                dbc.CardBody(
                    [
                        html.H3(id='card_title_3', children=['Count'], className='card-title',
                                style=CARD_TEXT_STYLE),
                        html.H4(id='card_text_3', children=['Place Holder'], style=CARD_TEXT_STYLE),
                        html.H6(id='card_info_3', children=["The number of videos opened."], style=CARD_TEXT_STYLE),

                    ],

                )
            ]
        ), md=3
    )
], justify="center")

app.layout = html.Div([
    html.H1(children="Time wasted on YouTube",
            style={'textAlign': 'center', "margin-top": "30px", "margin-bottom": "30px"}),
    dcc.Tabs(id="tabs", value='tab-1', children=[
        dcc.Tab(label='Personal', children=[
            html.H3(children="Choose student:", style={"margin-left": "30px"}),
            dcc.Dropdown(
                style={"margin-left": "5px", "margin-bottom": "15px"},
                id='dropdown',
                options=[
                    {'label': 'Szymon', 'value': 'SR'},
                    {'label': 'Krystian', 'value': 'KW'},
                    {'label': 'Konstany', 'value': 'KK'},
                    {'label': 'All', 'value': 'SS'}
                ],
                value="SR"
            ),
            html.H3(children="Choose date range:", style={"margin-left": "30px"}),
            dcc.DatePickerRange(
                style={"margin-left": "8px", "margin-bottom": "15px"},
                id='date-picker-range',
                start_date=date(2020, 12, 22),
                end_date=date(2021, 1, 15),
                display_format='Do MMM YY'
            ),
            first_row,
            dcc.Graph(
                id='Graph_with_slider',
                config={
                    'displayModeBar': False
                }
            ),
        ]),

        dcc.Tab(label='Comparison', children=[html.H3(children="Choose data:", style={"margin-left": "30px"}),
                                              dcc.Dropdown(
                                                  style={"margin-left": "5px", "margin-bottom": "15px"},
                                                  id='dropdown2',
                                                  options=[
                                                      {'label': 'Watched time', 'value': 'watched'},
                                                      {'label': 'Opened time', 'value': 'opened'},
                                                      {'label': 'Count', 'value': 'count'},
                                                  ],
                                                  value="watched"
                                              ),
                                              html.H3(children="Choose date range:", style={"margin-left": "30px"})
            , dcc.DatePickerRange(
                style={"margin-left": "8px", "margin-bottom": "15px"},
                id='date-picker-range2',
                start_date=date(2020, 12, 22),
                end_date=date(2021, 1, 15),
                display_format='Do MMM YY'
            ), first_row2, dcc.Graph(
                id='Graph_with_slider2',
                config={
                    'displayModeBar': False
                }
            )])
    ]),
    html.Div(id='tabs-content')
])


@app.callback(
    dash.dependencies.Output('Graph_with_slider', "figure"),
    dash.dependencies.Input('date-picker-range', "start_date"),
    dash.dependencies.Input('date-picker-range', "end_date"),
    dash.dependencies.Input('dropdown', "value"))
def update_figure(start, end, name):
    if name == "SR":
        df = Szymon
    elif name == "KK":
        df = Konstanty
    elif name == "KW":
        df = Krystian
    elif name == "SS":
        df = summedup
    time = pd.date_range(start=start, end=end).strftime("%Y-%m-%d").tolist()
    modified_df = df[df.date.isin(time)]
    fig = make_subplots(2, 1, specs=[[{"secondary_y": True}],
                                     [{"secondary_y": False}]],
                        subplot_titles=("Selected period data", "Ratio (Watched/Opened)"))
    colorS = ["#ffac98"] * len(modified_df["watched"])
    colorKW = ["#ef90a9"] * len(modified_df["watched"])
    colorKK = ["#007ac0"] * len(modified_df["watched"])
    fig.add_trace(
        go.Scatter(x=modified_df["date"], y=modified_df["watched"], hovertext=df["watchedTIME"].array,
                   hoverinfo="name+text", name="Watched", marker_color=colorS, line=dict(color="#ffac98", width=2)), 1,
        1,
        secondary_y=False)
    fig.add_trace(
        go.Scatter(x=modified_df["date"], y=modified_df["opened"], hovertext=df["openedTIME"].array,
                   hoverinfo="name+text", name="Opened", marker_color=colorKW, line=dict(color="#ef90a9", width=2)), 1,
        1,
        secondary_y=False)
    fig.add_trace(
        go.Scatter(x=modified_df["date"], y=modified_df["count"], hovertext=df["count"].array,
                   hoverinfo="text+name", name="Count", marker_color=colorKK, line=dict(color="#007ac0", width=2)), 1,
        1,
        secondary_y=True),
    fig.add_trace(
        go.Bar(x=modified_df["date"], y=modified_df["ratio"], name="Ratio", marker_color="#007096"), 2, 1,
        secondary_y=False)
    fig.update_xaxes(title_text="Date")
    fig.update_yaxes(title_text="<b>Time</b>", secondary_y=False, row=1, col=1)
    fig.update_yaxes(title_text="<b>Count</b>", secondary_y=True, showgrid=False, row=1, col=1)
    fig.update_yaxes(title_text="<b>Ratio</b>", secondary_y=False, row=2, col=1)
    fig.update_xaxes(matches='x')
    fig.update_layout(
        yaxis=dict(
            tickmode='array',
            tickvals=[0, 1800000 * 2, 1800000 * 4, 1800000 * 6,
                      1800000 * 8, 1800000 * 10, 1800000 * 12, 1800000 * 14, 1800000 * 16,
                      1800000 * 18, 1800000 * 20, 1800000 * 22, 1800000 * 24,
                      1800000 * 26, 1800000 * 28, 1800000 * 30, 1800000 * 32,
                      1800000 * 34],
            ticktext=["00:00:00", '01:00:00', '02:00:00', '03:00:00',
                      '04:00:00', '05:00:00', '06:00:00', '07:00:00',
                      '08:00:00',
                      '09:00:00', '10:00:00', '11:00:00', '12:00:00',
                      '13:00:00', '14:00:00', '15:00:00', '16:00:00',
                      '17:00:00']
        )
    )
    fig.update_yaxes(rangemode="tozero")
    fig.update_layout(hovermode="x")
    fig.update_layout(
        autosize=True,
        height=800)
    if datetime.datetime.strptime(start, "%Y-%m-%d") <= datetime.datetime.strptime("2020-12-26",
                                                                                   "%Y-%m-%d") and datetime.datetime.strptime(
        end, "%Y-%m-%d") >= datetime.datetime.strptime("2020-12-24", "%Y-%m-%d"):
        fig.add_vrect(
            x0="2020-12-24", x1="2020-12-26", annotation_text="Christmas", annotation_position="inside top right",
            annotation=dict(font_size=19),
            fillcolor="#355c7d", opacity=0.4,
            layer="below", line_width=0,
        )
    if datetime.datetime.strptime(start, "%Y-%m-%d") <= datetime.datetime.strptime("2021-01-01",
                                                                                   "%Y-%m-%d") and datetime.datetime.strptime(
        end, "%Y-%m-%d") >= datetime.datetime.strptime("2020-12-31", "%Y-%m-%d"):
        fig.add_vrect(
            x0="2020-12-31", x1="2021-01-01", annotation_text="New Years Eve",
            annotation_position="outside top right",
            annotation=dict(font_size=19),
            fillcolor="#c06cb4", opacity=0.5,
            layer="below", line_width=0,
        )
    fig.update_yaxes(fixedrange=True)

    return fig


@app.callback(
    dash.dependencies.Output("card_text_1", "children"),
    dash.dependencies.Input('date-picker-range', "start_date"),
    dash.dependencies.Input('date-picker-range', "end_date"),
    dash.dependencies.Input('dropdown', "value")
)
def update_card_text_1(start, end, name):
    if name == "SR":
        df = Szymon
    elif name == "KK":
        df = Konstanty
    elif name == "KW":
        df = Krystian
    elif name == "SS":
        df = summedup
    time = pd.date_range(start=start, end=end).strftime("%Y-%m-%d").tolist()
    modified_df = df[df.date.isin(time)]
    z = sum(modified_df["watched"])
    z = str(datetime.timedelta(seconds=z // 1000))
    return z


@app.callback(
    dash.dependencies.Output("card_text_2", "children"),
    dash.dependencies.Input('date-picker-range', "start_date"),
    dash.dependencies.Input('date-picker-range', "end_date"),
    dash.dependencies.Input('dropdown', "value")
)
def update_card_text_2(start, end, name):
    if name == "SR":
        df = Szymon
    elif name == "KK":
        df = Konstanty
    elif name == "KW":
        df = Krystian
    elif name == "SS":
        df = summedup
    time = pd.date_range(start=start, end=end).strftime("%Y-%m-%d").tolist()
    modified_df = df[df.date.isin(time)]
    z = sum(modified_df["opened"])
    z = str(datetime.timedelta(seconds=z // 1000))
    return z


@app.callback(
    dash.dependencies.Output("card_text_3", "children"),
    dash.dependencies.Input('date-picker-range', "start_date"),
    dash.dependencies.Input('date-picker-range', "end_date"),
    dash.dependencies.Input('dropdown', "value")
)
def update_card_text_3(start, end, name):
    if name == "SR":
        df = Szymon
    elif name == "KK":
        df = Konstanty
    elif name == "KW":
        df = Krystian
    elif name == "SS":
        df = summedup
    time = pd.date_range(start=start, end=end).strftime("%Y-%m-%d").tolist()
    modified_df = df[df.date.isin(time)]
    z = sum(modified_df["count"])
    return z


@app.callback(
    dash.dependencies.Output('Graph_with_slider2', "figure"),
    dash.dependencies.Input('date-picker-range2', "start_date"),
    dash.dependencies.Input('date-picker-range2', "end_date"),
    dash.dependencies.Input('dropdown2', "value"))
def update_figure(start, end, att):
    att2 = att + "TIME"
    if att == "count":
        att2 = att
    time = pd.date_range(start=start, end=end).strftime("%Y-%m-%d").tolist()
    Smodified_df = Szymon[Szymon.date.isin(time)]
    KWmodified_df = Krystian[Krystian.date.isin(time)]
    KKmodified_df = Konstanty[Konstanty.date.isin(time)]
    colorS = ["#6c5b7b"] * len(Smodified_df[att])
    colorKW = ["#F67280"] * len(Smodified_df[att])
    colorKK = ["#F8B195"] * len(Smodified_df[att])
    fig = make_subplots(2, 1, shared_yaxes=True,subplot_titles=("Comparison of selected data", "Stacked data"))
    fig.add_trace(
        go.Scatter(x=Smodified_df["date"], y=Smodified_df[att], hovertext=Smodified_df[att2].array,
                   hoverinfo="name+text", name="Szymon", fillcolor="#f54242", legendgroup="Szymon", showlegend=False,
                   marker_color=colorS, line=dict(color="#6c5b7b", width=2)), 1, 1,
        secondary_y=False)
    fig.add_trace(
        go.Scatter(x=KWmodified_df["date"], y=KWmodified_df[att], hovertext=KWmodified_df[att2].array,
                   hoverinfo="name+text", name="Krystian", legendgroup="Krystian", showlegend=False,
                   marker_color=colorKW, line=dict(color="#F67280", width=2)), 1, 1,
        secondary_y=False)
    fig.add_trace(
        go.Scatter(x=KKmodified_df["date"], y=KKmodified_df[att], hovertext=KKmodified_df[att2].array,
                   hoverinfo="text+name", name="Konstanty", legendgroup="Konstanty", showlegend=False,
                   marker_color=colorKK, line=dict(color="#F8B195", width=2)), 1, 1,
        secondary_y=False, )
    fig.add_trace(
        go.Bar(name='Szymon', x=Smodified_df["date"], y=Smodified_df[att], hovertext=Smodified_df[att2].array,
               hoverinfo="text+name", legendgroup="Szymon", marker_color=colorS), 2, 1)
    fig.add_trace(
        go.Bar(name='Krystian', x=KWmodified_df["date"], y=KWmodified_df[att], hovertext=KWmodified_df[att2].array,
               hoverinfo="text+name", legendgroup="Krystian", marker_color=colorKW), 2, 1)
    fig.add_trace(
        go.Bar(name='Konstanty', x=KKmodified_df["date"], y=KKmodified_df[att], hovertext=KKmodified_df[att2].array,
               hoverinfo="text+name", legendgroup="Konstanty", marker_color=colorKK), 2, 1)
    fig.update_xaxes(title_text="Date")
    fig.update_layout(barmode='stack')
    fig.update_xaxes(matches='x')
    if att == "count":
        fig.update_yaxes(title_text="<b>Count</b>", secondary_y=False)
        fig.update_yaxes(title_text="<b>Count</b>", secondary_y=False)
    else:
        fig.update_yaxes(title_text="<b>Time</b>", secondary_y=False)
        fig.update_layout(
            yaxis=dict(
                tickmode='array',
                tickvals=[0, 1800000 * 2, 1800000 * 4, 1800000 * 6,
                          1800000 * 8, 1800000 * 10, 1800000 * 12, 1800000 * 14, 1800000 * 16,
                          1800000 * 18, 1800000 * 20, 1800000 * 22, 1800000 * 24,
                          1800000 * 26, 1800000 * 28, 1800000 * 30, 1800000 * 32,
                          1800000 * 34],
                ticktext=["00:00:00", '01:00:00', '02:00:00', '03:00:00',
                          '04:00:00', '05:00:00', '06:00:00', '07:00:00',
                          '08:00:00',
                          '09:00:00', '10:00:00', '11:00:00', '12:00:00',
                          '13:00:00', '14:00:00', '15:00:00', '16:00:00',
                          '17:00:00']
            )
            , yaxis2=dict(
                tickmode='array',
                tickvals=[0, 1800000 * 2, 1800000 * 4, 1800000 * 6,
                          1800000 * 8, 1800000 * 10, 1800000 * 12, 1800000 * 14, 1800000 * 16,
                          1800000 * 18, 1800000 * 20, 1800000 * 22, 1800000 * 24,
                          1800000 * 26, 1800000 * 28, 1800000 * 30, 1800000 * 32,
                          1800000 * 34],
                ticktext=["00:00:00", '01:00:00', '02:00:00', '03:00:00',
                          '04:00:00', '05:00:00', '06:00:00', '07:00:00',
                          '08:00:00',
                          '09:00:00', '10:00:00', '11:00:00', '12:00:00',
                          '13:00:00', '14:00:00', '15:00:00', '16:00:00',
                          '17:00:00']
            ))

    fig.update_layout(
        autosize=True,
        height=700)
    fig.update_yaxes(rangemode="tozero")
    fig.update_layout(hovermode="x")
    if datetime.datetime.strptime(start, "%Y-%m-%d") <= datetime.datetime.strptime("2020-12-26",
                                                                                   "%Y-%m-%d") and datetime.datetime.strptime(
        end, "%Y-%m-%d") >= datetime.datetime.strptime("2020-12-24", "%Y-%m-%d"):
        fig.add_vrect(
            x0="2020-12-24", x1="2020-12-26", annotation_text="Christmas", annotation_position="inside top right",
            annotation=dict(font_size=20),
            fillcolor="#355c7d", opacity=0.4,
            layer="below", line_width=0,
        )
    if datetime.datetime.strptime(start, "%Y-%m-%d") <= datetime.datetime.strptime("2021-01-01",
                                                                                   "%Y-%m-%d") and datetime.datetime.strptime(
        end, "%Y-%m-%d") >= datetime.datetime.strptime("2020-12-31", "%Y-%m-%d"):
        fig.add_vrect(
            x0="2020-12-31", x1="2021-01-01", annotation_text="New Years Eve",
            annotation_position="outside top right",
            annotation=dict(font_size=20),
            fillcolor="#c06cb4", opacity=0.5,
            layer="below", line_width=0,
        )
    fig.update_yaxes(fixedrange=True)
    return fig


@app.callback(
    dash.dependencies.Output("card_text_Szymon", "children"),
    dash.dependencies.Input('date-picker-range2', "start_date"),
    dash.dependencies.Input('date-picker-range2', "end_date"),
    dash.dependencies.Input('dropdown2', "value")
)
def update_card_Szymon(start, end, att):
    time = pd.date_range(start=start, end=end).strftime("%Y-%m-%d").tolist()
    modified_df = Szymon[Szymon.date.isin(time)]
    z = sum(modified_df[att])
    if att == "watched" or att == "opened":
        z = str(datetime.timedelta(seconds=z // 1000))
    return z


@app.callback(
    dash.dependencies.Output("card_text_Krystian", "children"),
    dash.dependencies.Input('date-picker-range2', "start_date"),
    dash.dependencies.Input('date-picker-range2', "end_date"),
    dash.dependencies.Input('dropdown2', "value")
)
def update_card_Krystian(start, end, att):
    time = pd.date_range(start=start, end=end).strftime("%Y-%m-%d").tolist()
    modified_df = Krystian[Krystian.date.isin(time)]
    z = sum(modified_df[att])
    if att == "watched" or att == "opened":
        z = str(datetime.timedelta(seconds=z // 1000))
    return z


@app.callback(
    dash.dependencies.Output("card_text_Konstanty", "children"),
    dash.dependencies.Input('date-picker-range2', "start_date"),
    dash.dependencies.Input('date-picker-range2', "end_date"),
    dash.dependencies.Input('dropdown2', "value")
)
def update_card_Konstanty(start, end, att):
    time = pd.date_range(start=start, end=end).strftime("%Y-%m-%d").tolist()
    modified_df = Konstanty[Konstanty.date.isin(time)]
    z = sum(modified_df[att])
    if att == "watched" or att == "opened":
        z = str(datetime.timedelta(seconds=z // 1000))
    return z


if __name__ == '__main__':
    app.run_server(debug=True)
