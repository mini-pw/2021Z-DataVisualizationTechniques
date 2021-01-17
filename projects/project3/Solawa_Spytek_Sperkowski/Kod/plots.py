import dash
import os
import dash_core_components as dcc
import dash_html_components as html
import dash_bootstrap_components as dbc
from dash.dependencies import Input, Output
import pandas as pd
import plotly.express as px
from wordcloud import WordCloud
from datetime import datetime
import time
from dateutil.relativedelta import relativedelta
import matplotlib.colors as mcolors

# HELPER FUNCTIONS

def unixTimeMillis(dt):
    ''' Convert datetime to unix timestamp '''
    return int(time.mktime(dt.timetuple()))


def unixToDatetime(unix):
    ''' Convert unix timestamp to datetime. '''
    return pd.to_datetime(unix, unit='s')


def getMarks(start, end, Nth=100):
    ''' Returns the marks for labeling.
        Every Nth value will be used.
    '''

    result = []
    current = start
    while current <= end:
        result.append(current)
        current += relativedelta(months=6)
    result.pop()
    result.append(end)
    return {unixTimeMillis(m): (str(m.strftime('%Y-%m'))) for m in result}


def generateMessageOwner(val, owner):
    if val == owner:
        return "Sent"
    else:
        return "Received"

def generatePersonWordCloudImage(thread, isowner, range):
    wcimg = None
    df_slice = df.loc[df["thread_name"] == thread]
    start = datetime.fromtimestamp(range[0])
    end = datetime.fromtimestamp(range[1])

    date_list = pd.to_datetime(df_slice['date'].tolist())
    mask = (date_list >= start) & (date_list <= end)
    df_slice = df_slice.loc[mask]
    if isowner:
        text = df_slice.loc[df_slice["author"]
                            == owner].content.str.cat(sep=" ")
    else:
        text = df_slice.loc[df_slice["author"]
                            != owner].content.str.cat(sep=" ")
    if len(text) > 0:
        wordcloud = WordCloud(
            width=1200,
            height=600,
            background_color="white",
            mode="RGBA",
            stopwords=stop_words,
            collocations=False,
            colormap=mcolors.LinearSegmentedColormap.from_list('custom colormap', ['#47A8BD', '#FFAD69'], N=2)
        ).generate(text)
        wcimg = wordcloud.to_image()
    return wcimg





# PREPARING GLOBAL VARIABLES


# external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
external_stylesheets = [dbc.themes.BOOTSTRAP]

# words not to include in the wordclouds sourced from
# https://github.com/fergiemcdowall/stopword
stop_words = [
    'a', 'aby', 'ach', 'acz', 'aczkolwiek', 'aj', 'albo', 'ale', 'ależ', 'ani', 'sie',
    'aż', 'bardziej', 'bardzo', 'bo', 'bowiem', 'by', 'byli', 'bynajmniej',
    'być', 'był', 'była', 'było', 'były', 'będzie', 'będą', 'cali', 'cała',
    'cały', 'ci', 'cię', 'ciebie', 'co', 'cokolwiek', 'coś', 'czasami',
    'czasem', 'czemu', 'czy', 'czyli', 'daleko', 'dla', 'dlaczego', 'dlatego',
    'do', 'dobrze', 'dokąd', 'dość', 'dużo', 'dwa', 'dwaj', 'dwie', 'dwoje',
    'dziś', 'dzisiaj', 'gdy', 'gdyby', 'gdyż', 'gdzie', 'gdziekolwiek',
    'gdzieś', 'i', 'ich', 'ile', 'im', 'inna', 'inne', 'inny', 'innych', 'iż',
    'ja', 'ją', 'jak', 'jakaś', 'jakby', 'jaki', 'jakichś', 'jakie', 'jakiś',
    'jakiż', 'jakkolwiek', 'jako', 'jakoś', 'je', 'jeden', 'jedna', 'jedno',
    'jednak', 'jednakże', 'jego', 'jej', 'jemu', 'jest', 'jestem', 'jeszcze',
    'jeśli', 'jeżeli', 'już', 'ją', 'każdy', 'kiedy', 'kilka', 'kimś', 'kto',
    'ktokolwiek', 'ktoś', 'która', 'które', 'którego', 'której', 'który',
    'których', 'którym', 'którzy', 'ku', 'lat', 'lecz', 'lub', 'ma', 'mają',
    'mało', 'mam', 'mi', 'mimo', 'między', 'mną', 'mnie', 'mogą', 'moi', 'moim',
    'moja', 'moje', 'może', 'możliwe', 'można', 'mój', 'mu', 'musi', 'my', 'na',
    'nad', 'nam', 'nami', 'nas', 'nasi', 'nasz', 'nasza', 'nasze', 'naszego',
    'naszych', 'natomiast', 'natychmiast', 'nawet', 'nią', 'nic', 'nich', 'nie',
    'niech', 'niego', 'niej', 'niemu', 'nigdy', 'nim', 'nimi', 'niż', 'no', 'o',
    'obok', 'od', 'około', 'on', 'ona', 'one', 'oni', 'ono', 'oraz', 'oto',
    'owszem', 'pan', 'pana', 'pani', 'po', 'pod', 'podczas', 'pomimo', 'ponad',
    'ponieważ', 'powinien', 'powinna', 'powinni', 'powinno', 'poza', 'prawie',
    'przecież', 'przed', 'przede', 'przedtem', 'przez', 'przy', 'roku',
    'również', 'sam', 'sama', 'są', 'się', 'skąd', 'sobie', 'sobą', 'sposób',
    'swoje', 'ta', 'tak', 'taka', 'taki', 'takie', 'także', 'tam', 'te', 'tego',
    'tej', 'temu', 'ten', 'teraz', 'też', 'to', 'tobą', 'tobie', 'toteż',
    'trzeba', 'tu', 'tutaj', 'twoi', 'twoim', 'twoja', 'twoje', 'twym', 'twój',
    'ty', 'tych', 'tylko', 'tym', 'u', 'w', 'wam', 'wami', 'was', 'wasz', 'zaś',
    'wasza', 'wasze', 'we', 'według', 'wiele', 'wielu', 'więc', 'więcej', 'tę',
    'wszyscy', 'wszystkich', 'wszystkie', 'wszystkim', 'wszystko', 'wtedy',
    'wy', 'właśnie', 'z', 'za', 'zapewne', 'zawsze', 'ze', 'zł', 'znowu',
    'znów', 'został', 'żaden', 'żadna', 'żadne', 'żadnych', 'że', 'żeby',
    '$', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '_']

basedirectory = os.path.dirname(os.path.abspath(__file__))

# getting the messages 'owners' name
ownernamepath = os.path.join(basedirectory, "owner.txt")
with open(ownernamepath, mode="r", encoding="utf-8") as ownerfile:
    owner = ownerfile.read()

# preparing reactions dataframe
reactionfile = os.path.join(basedirectory, "reactions.csv")
df_reactions = pd.read_csv(reactionfile)
df_reactions["who"] = df_reactions["reacting_person"].apply(
    generateMessageOwner, args=(owner,))

# preparing main messages dataframe
messagefile = os.path.join(basedirectory, "messages.csv")
df = pd.read_csv(messagefile)
df["who"] = df["author"].apply(generateMessageOwner, args=(owner,))
df['dateformat'] = pd.to_datetime(df['date'])

# LAYOUT TEMPLATES FOR EACH TAB

tab1_layout = html.Div([
    html.H2("Summary of your data"),
    html.Div(id="time-histogram-container"),
    html.Div(id="hour-histogram-container"),
    dcc.Markdown(id ="statistic")
])

tab2_layout = html.Div([
    html.H2("Data of a private conversation thread"),
    html.Div(
        id="person-charts-container",
        children=[
            html.Div(id="person-time-histogram-container"),
            html.Div(id="person-hour-histogram-container"),
            html.Div(id="person-wordclouds-container")
        ]
    )
])

tab3_layout = html.Div([
    html.H2("Data of reactions in your threads"),
    html.Div(id="reactions-output",
             children=[
                 html.Div(id="reactions-container")
             ])
])

# MAIN APP FUNCTIONALITY

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

app.config.suppress_callback_exceptions = True

app.layout = dbc.Container([
    dbc.Row([
        dbc.Col([
            dbc.Card(
                dbc.CardBody(
                    dbc.Tabs(id="tabs", active_tab="tab1", children=[
                        dbc.Tab(label="Your summary", tab_id="tab1"),
                        dbc.Tab(label="People", tab_id="tab2", children=[
                            html.P("Select a person:"),
                            dcc.Dropdown(
                                id="person-dropdown",
                                options=[{"label": str(name), "value": str(name)} for name in
                                         df.loc[df["thread_type"] == "Regular"].thread_name.unique()])
                        ]),
                        dbc.Tab(label="Reactions", tab_id="tab3", children=[
                            html.P("Select a person:"),
                            dcc.Dropdown(
                                id="reactions-dropdown",
                                options=[{"label": str(name), "value": str(name)} for name in
                                         df.loc[df["thread_type"] == "Regular"].thread_name.unique()])
                        ])
                    ])
                ), className="mb-3"
            ),
            dbc.Card([
                html.H3("Your Messenger Conversations", className="pt-4 px-4"),
                dbc.CardBody(
                    html.P(["We invite you to explore your Messenger conversation data. ",
                            html.Br(),
                            "Choose a time period, hover with your mouse over the plot, click on the legend ",
                            "or go to a different tab. ",
                           "After choosing a period please wait a few seconds for the plots to reload. ",
                            html.Br(),
                            html.Br(),
                            "Authors: Katarzyna Solawa, Mikołaj Spytek, Mateusz Sperkowski"])
                )]
            )
        ], md=3
        ),
        dbc.Col([
            dbc.Card([
                html.Div([
                    html.H3("Choose a time period"),
                    dcc.RangeSlider(
                        id='year_slider1',
                        min=unixTimeMillis(pd.to_datetime(df['date'].tolist()).min()),
                        max=unixTimeMillis(pd.to_datetime(df['date'].tolist()).max()),
                        value=[unixTimeMillis(pd.to_datetime(df['date'].tolist()).min()),
                               unixTimeMillis(pd.to_datetime(df['date'].tolist()).max())],
                        marks=getMarks(pd.to_datetime(df['date'].tolist()).min(),
                                       pd.to_datetime(df['date'].tolist()).max()),
                        step=86400,
                        pushable=200000
                    ),
                    html.Div(id='slider-period1', className="mb-3")],
                    className="pt-4 px-4")], className="mb-3"
            ),
            dbc.Card([
                html.Div(id="content", className="pt-4 px-4")]
            ), ], md=9, className="overflow-auto"
        )
    ])

], fluid=True, className="pt-4")


# CALLBACKS

# General tab selection callback


@app.callback(Output("content", "children"), Input("tabs", "active_tab"))
def render_content(tab):
    if tab == "tab1":
        return tab1_layout
    elif tab == "tab2":
        return tab2_layout
    else:
        return tab3_layout



def showPeriod(range):
    start1 = datetime.fromtimestamp(range[0])
    end1 = datetime.fromtimestamp(range[1])
    start_label = str(start1.strftime('%Y-%m-%d'))
    end_label = str(end1.strftime('%Y-%m-%d'))
    return f'Period from {start_label} to {end_label}'


# Second tab callbacks
@app.callback(Output("slider-period1", "children"),
              Input("year_slider1", "value"),)
def showPeriod1(range):
    return showPeriod(range)


@app.callback(Output("time-histogram-container", "children"),
              Input("year_slider1", "value"),)
def generalTimeHistogram(range):
    start = datetime.fromtimestamp(range[0])
    end = datetime.fromtimestamp(range[1])
    date_list = pd.to_datetime(df['date'].tolist())
    mask = (date_list >= start) & (date_list <= end)
    df_slice = df.loc[mask]
    if df_slice.size == 0:
        return html.Div(children='No messages in this period', style={'textAlign': 'center'})
    timeHistogram = px.histogram(df_slice, x="date", color="who",
                                 color_discrete_sequence=[
                                     "#47A8BD", "#FFAD69"], title="Your messages over time", labels={
        "date": "Date", "who": "Messages:"})
    timeHistogram.update_yaxes(title_text="Number of messages", fixedrange=True)
    timeHistogram.update_xaxes(fixedrange=True)
    timeHistogram.update_layout(hovermode="x",
                                legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1),
                                legend_title=dict(font=dict(size=15)), title=dict(font=dict(size=23)))
    timeHistogram.update_traces(hovertemplate='Number of messages: %{y:f}')
    return dcc.Graph(
        id="default-histogram",
        figure=timeHistogram,
        config=dict(
            displayModeBar=False
        )
    ),

@app.callback(Output("hour-histogram-container", "children"),
              Input("year_slider1", "value"),)
def generalHourHistogram(range):
    start = datetime.fromtimestamp(range[0])
    end = datetime.fromtimestamp(range[1])
    date_list = pd.to_datetime(df['date'].tolist())
    mask = (date_list >= start) & (date_list <= end)
    df_slice = df.loc[mask]
    if df_slice.size == 0:
        return html.Div(children='No messages in this period', style={'textAlign': 'center'})

    hourHistogram = px.histogram(df_slice, x="hour", color="who", range_x=[-0.5, 23.5], nbins=24,
                                 title="Breakdown of messages sent by hour",
                                 color_discrete_sequence=[
                                     "#47A8BD", "#FFAD69"],
                                 labels={"who": "Messages: "})
    hourHistogram.update_yaxes(title_text="Number of messages", fixedrange=True)
    hourHistogram.update_xaxes(title_text="Hour of day", nticks=24, tickmode='linear',
                               tick0=0.0, dtick=1.0, fixedrange=True)
    hourHistogram.update_layout(hovermode="x", bargap=0.1,
                                legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1),
                                legend_title=dict(font=dict(size=15)), title=dict(font=dict(size=23)))
    hourHistogram.update_traces(hovertemplate='Number of messages: %{y:f}')

    return dcc.Graph(
        id="hour-histogram",
        figure=hourHistogram,
        config=dict(
            displayModeBar=False
        )
    )
@app.callback(Output("statistic", "children"),
              Input("year_slider1", "value"),)
def generateStatistics(range):
    start = datetime.fromtimestamp(range[0])
    end = datetime.fromtimestamp(range[1])
    date_list = pd.to_datetime(df['date'].tolist())
    mask = (date_list >= start) & (date_list <= end)
    df_slice = df.loc[mask]
    if df_slice.size == 0:
        return html.Div(children='No messages in this period', style={'textAlign': 'center'})

    endDateString = df_slice["date"].max()
    startDateString = df_slice["date"].min()
    startDate = datetime.fromisoformat(startDateString)
    endDate = datetime.fromisoformat(endDateString)
    startDateFormated = startDate.strftime("%A, the %d. %B %Y")
    endDateFormated = endDate.strftime("%A, the %d. %B %Y")
    numYourMsg = len(df_slice.loc[df_slice["author"] == owner])
    numTheirMsg = len(df_slice.loc[df_slice["author"] != owner])
    daysNum = abs(endDate - startDate).days
    daysNum += 1
    avgYourMsgPerDay = numYourMsg / daysNum
    avgYourWordCount = df_slice.loc[df_slice["author"] == owner, "words"].mean()
    avgYourCharCount = df_slice.loc[df_slice["author"] == owner, "chars"].mean()
    avgTheirMsgPerDay = numTheirMsg / daysNum
    avgTheirWordCount = df_slice.loc[df_slice["author"] != owner, "words"].mean()
    avgTheirCharCount = df_slice.loc[df_slice["author"] != owner, "chars"].mean()

    return """
    ## Statistics
    We're analyzing your data from **{}**, to  **{}**, that is **{} days**.

    In that time period **you sent {} messages** and **received {} messages**. That makes a total of {} messeges.

    On average, **you've written {:.2f} messages per day**, and each of those consisted on average of {:.2f} words, or {:.2f} characters.

    On the other hand, **you've received {:.2f} messages per day**, and each of those consisted on average of {:.2f} words, or {:.2f} characters.


    """.format(startDateFormated,
               endDateFormated,
               daysNum,
               numYourMsg,
               numTheirMsg,
               numTheirMsg + numYourMsg,
               avgYourMsgPerDay,
               avgYourWordCount,
               avgYourCharCount,
               avgTheirMsgPerDay,
               avgTheirWordCount,
               avgTheirCharCount)




@app.callback(Output("person-time-histogram-container", "children"),
              Input("person-dropdown", "value"),
              Input("year_slider1", "value"))
def personTimeHistogram(person, range):
    if person:
        df_slice = df.loc[df["thread_name"] == person]
        start = datetime.fromtimestamp(range[0])
        end = datetime.fromtimestamp(range[1])
        date_list = pd.to_datetime(df_slice['date'].tolist())
        mask = (date_list >= start) & (date_list <= end)
        df_slice = df_slice.loc[mask]
        if df_slice.size == 0:
            return html.Div(children='No messages in this period', style={'textAlign': 'center'})

        personTimeHistogram = px.histogram(df_slice, x="date", color="author",
                                 color_discrete_sequence=[
                                     "#47A8BD", "#FFAD69"],
                                           labels={"author": "Author: "},
                                           title="Your conversation through the time period")
        personTimeHistogram.update_yaxes(title_text="Number of messages", fixedrange=True)
        personTimeHistogram.update_xaxes(title_text="Date", fixedrange=True)
        personTimeHistogram.update_layout(hovermode="x", legend=dict(orientation="h", yanchor="bottom", y=1.02,
                                                                     xanchor="right", x=1),
                                          legend_title=dict(font=dict(size=15)), title=dict(font=dict(size=23)))
        personTimeHistogram.update_traces(
            hovertemplate='Number of messages: %{y:f}')
        return dcc.Graph(
            id="person-histogram",
            figure=personTimeHistogram,
            config=dict(
                displayModeBar=False
            )
        )


@app.callback(Output("person-hour-histogram-container", "children"),
              Input("person-dropdown", "value"),
              Input("year_slider1", "value"))
def personHourHistogram(person, range):
    if person:
        df_slice = df.loc[df["thread_name"] == person]
        start = datetime.fromtimestamp(range[0])
        end = datetime.fromtimestamp(range[1])
        date_list = pd.to_datetime(df_slice['date'].tolist())
        mask = (date_list >= start) & (date_list <= end)
        df_slice = df_slice.loc[mask]
        if df_slice.size == 0:
            return html.Div(children='No messages in this period', style={'textAlign': 'center'})
        personHourHistogram = px.histogram(df_slice, x="hour", color="author", range_x=[-0.5, 23.5], nbins=24,
                                           title="Breakdown of messages sent by hour",
                                 color_discrete_sequence=[
                                     "#47A8BD", "#FFAD69"], labels={"author": "Author: "})
        personHourHistogram.update_yaxes(title_text="Number of messages", fixedrange=True)
        personHourHistogram.update_xaxes(
            title_text="Hour of day", nticks=24, tickmode='linear', tick0=0.0, dtick=1.0, fixedrange=True)
        personHourHistogram.update_layout(bargap=0.1, hovermode="x",
                                          legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1),
                                          legend_title=dict(font=dict(size=15)), title=dict(font=dict(size=23)))
        personHourHistogram.update_traces(
            hovertemplate='Number of messages: %{y:f}')

        return dcc.Graph(
            id="person-hour-histogram",
            figure=personHourHistogram,
            config=dict(
                displayModeBar=False
            )
        )



@app.callback(Output("person-wordclouds-container", "children"),
              Input("person-dropdown", "value"),
              Input("year_slider1", "value"))
def personWordclouds(person, range):
    if person:
        yourWordcloud = generatePersonWordCloudImage(person, True, range)
        theirWordcloud = generatePersonWordCloudImage(person, False, range)

        return html.Div(id="wordcloud-container",
                        children=html.Div(
                            children=[
                                html.Div(
                                    children=[
                                        html.H2(
                                            children=["Your wordcloud"]),
                                        html.Img(src=yourWordcloud, style={
                                            "display": "block", "width": "100%"})
                                    ],
                                    style={"display": "inline-block", "marginLeft": "auto",
                                           "marginRight": "auto", "width": "40%", "paddingRight": "3%"}
                                ),
                                html.Div(
                                    children=[
                                        html.H2(
                                            children=["Their wordcloud"]),
                                        html.Img(src=theirWordcloud, style={
                                            "display": "block", "width": "100%"})
                                    ],
                                    style={"display": "inline-block", "marginLeft": "auto",
                                           "marginRight": "auto", "width": "40%", "paddingLeft": "3%"}
                                )

                            ],
                            style={"textAlign": "center"}
                        )
                        )


# third tab callbacks

@app.callback(Output("reactions-container", "children"),
              Input("reactions-dropdown", "value"),
              Input("year_slider1", "value"))
def chatReactions(person, range):
    if person:
        df_sl = df_reactions.loc[df_reactions["thread_name"] == person]

        start = datetime.fromtimestamp(range[0])
        end = datetime.fromtimestamp(range[1])
        date_list = pd.to_datetime(df_sl['date'].tolist())
        mask = (date_list >= start) & (date_list <= end)
        df_sl = df_sl.loc[mask]
        if df_sl.size == 0:
            return html.Div(children='No reactions in this period', style={'textAlign': 'center'})

        top = df_sl.groupby(["emoji", "reacting_person"]).size()
        top = top.reset_index(level=['emoji', 'reacting_person']).rename(columns={0: "count"})
        top = top.loc[top["count"] > 0]
        if top.size == 0:
            return html.Div(children='No reactions in this period', style={'textAlign': 'center'})
        mostMessagesHistogram = px.bar(top,
                                       y="emoji", x="count", orientation="h",
                                 color_discrete_sequence=[
                                     "#47A8BD", "#FFAD69"], color="reacting_person",
                                       title=f"Your reactions in chat with {person}",
                                       labels={"reacting_person": "Person who reacted: "})
        mostMessagesHistogram.update_yaxes(title_text="Emoji", categoryorder="total ascending", fixedrange=True)
        mostMessagesHistogram.update_xaxes(title_text="Number of reactions", fixedrange=True)
        mostMessagesHistogram.update_layout(hovermode="closest",
                                            legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1),
                                            legend_title=dict(font=dict(size=15)), title=dict(font=dict(size=23)))
        mostMessagesHistogram.update_traces(
            hovertemplate='Number of reactions: %{x:f}, %{y}')

        return dcc.Graph(id="mostMessages",
                         figure=mostMessagesHistogram,
                         config=dict(
                             displayModeBar=False
                         )
                         )


if __name__ == "__main__":
    app.run_server()
