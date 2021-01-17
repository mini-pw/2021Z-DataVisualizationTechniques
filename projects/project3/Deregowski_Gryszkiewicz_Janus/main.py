import dash_table
import dash_core_components as dcc
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials, SpotifyOAuth
import dash
import dash_html_components as html
from dash.dependencies import Input, Output, State
import plotly.express as px
import pandas as pd
from plotly.subplots import make_subplots
import plotly.graph_objects as go

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)
colors = {
    'background': '#191414',
    'text': '#1DB954'
}
scope = "user-read-recently-played user-top-read user-read-currently-playing playlist-read-private " \
        "playlist-read-collaborative user-library-read user-read-playback-state "
sp = spotipy.Spotify(auth_manager=SpotifyOAuth(scope=scope))


# wyświetlanie tytułów top utworów + nazwy wykonawców
def top_tracks(time_range="short_term", limit=20, offset=0):
    if time_range != "short_term" and time_range != "medium_term" and time_range != "long_term":
        return

    top_tracks = sp.current_user_top_tracks(limit, offset, time_range)

    position = []
    position_ = offset
    name = []
    artists = []
    song_id = []
    artists_id = []
    img_url = []
    for song in top_tracks["items"]:
        position_ += 1
        position.append(position_)
        name.append(song["name"])
        artists_ = []
        artists_id_ = []
        for artist in song["artists"]:
            artists_.append(artist["name"])
            artists_id_.append(artist["id"])
        artists.append(artists_)
        artists_id.append(artists_id_)
        song_id.append(song["id"])
        img_url.append("![](" + str(song["album"]["images"][-1]["url"]) + ")")

    top_tracks_df = pd.DataFrame({"Pos.": position,
                                  "Song": name,
                                  "Artists": artists,
                                  "Song_ID": song_id,
                                  "Artists_ID": artists_id,
                                  "Album cover": img_url})

    return top_tracks_df


# średnia popularność topowych utworów
def top_tracks_avg_popularity(time_range="short_term", limit=10, offset=0):
    if time_range != "short_term" and time_range != "medium_term" and time_range != "long_term":
        return

    top_tracks = sp.current_user_top_tracks(limit, offset, time_range)

    i = 0
    avg_popularity = 0
    for song in top_tracks["items"]:
        i += 1
        avg_popularity += song['popularity']
    avg_popularity = avg_popularity / i

    print(
        "\nŚREDNIA POPULARNOŚĆ TWOICH TOP " + str(limit) + " UTWORÓW TO : " + str(avg_popularity) + " W SKALI 1 - 100.")

    return avg_popularity


# wyświetlanie top wykonawców
def top_artists(time_range="short_term", limit=10, offset=0):
    if time_range != "short_term" and time_range != "medium_term" and time_range != "long_term":
        return

    top_artists = sp.current_user_top_artists(limit, offset, time_range)

    position = []
    position_ = offset
    name = []
    image = []

    for artist in top_artists["items"]:
        position_ += 1
        position.append(position_)
        name.append(artist["name"])
        image.append("![](" + str(artist["images"][-1]["url"]) + ")")

    top_artists_df = pd.DataFrame({"Pos.": position, "Artist": name, "Artist image": image})
    return top_artists_df


# sprawdzanie top 10 najpopularniejszych gatunków
def top_genres(time_range="short_term", limit=10, offset=0):
    if time_range != "short_term" and time_range != "medium_term" and time_range != "long_term":
        return

    top_tracks = sp.current_user_top_tracks(limit, offset, time_range)

    genres = dict()

    for song in top_tracks["items"]:
        for artist in song['artists']:
            for genre in sp.artist(artist['id'])['genres']:
                if genre in genres:
                    genres[genre] += 1
                else:
                    genres[genre] = 1
    genres = {k: v for k, v in sorted(genres.items(), key=lambda item: item[1], reverse=True)}
    k = offset
    position = []
    position_ = offset
    genrs = []
    values = []
    for gen in genres.keys():
        position_ += 1
        position.append(position_)
        genrs.append(gen)
        values.append(genres[gen])

    top_genres_df = pd.DataFrame({"Pos.": position,
                                  "Genres": genrs,
                                  "No. tracks": values})

    return top_genres_df




# najpopularniejsze ery (np muzyka '90)
def top_tracks_era(time_range="short_term", limit=50, offset=0):
    if time_range != "short_term" and time_range != "medium_term" and time_range != "long_term":
        return
    eras = dict()
    top_tracks = sp.current_user_top_tracks(limit, offset, time_range)
    for track in top_tracks["items"]:
        if track['album']['release_date_precision'] == "day":
            year = int(track['album']['release_date'][0:4])
            era = year - year % 10
            if era in eras:
                eras[era] += 1
            else:
                eras[era] = 1

    eras = {k: v for k, v in sorted(eras.items(), key=lambda item: item[1], reverse=True)}

    position =[]
    position_ = offset
    eras2 = []
    values = []
    for era in eras.keys():
        position_ +=1
        position.append(position_)
        eras2.append(era)
        values.append(eras[era])
    top_eras_df = pd.DataFrame({"Pos.": position,
                                "Era" : eras2,
                                "No. tracks" : values})
    return top_eras_df

def top_tracks_features(time_range="short_term", limit=10, offset=0):
    if time_range != "short_term" and time_range != "medium_term" and time_range != "long_term":
        return

    top_tracks = sp.current_user_top_tracks(limit, offset, time_range)
    top_tracks_ids = []
    title = []
    for track in top_tracks["items"]:
        top_tracks_ids.append(track["id"])
        title.append(str(track["name"]) + " - " + str(track["artists"][0]["name"]))

    avg_danceability = 0
    avg_energy = 0
    avg_duration = 0
    i = 0
    danceability = []
    energy = []
    duration = []
    max_danceability = 0
    max_danceability_id = ""
    max_energy = 0
    max_energy_id = ""
    max_duration = 0
    max_duration_id = ""

    for track in sp.audio_features(top_tracks_ids):  # ["audio_features"]:
        current_danceability = track["danceability"]
        current_energy = track["energy"]
        current_duration = track["duration_ms"]

        if current_danceability > max_danceability:
            max_danceability = current_danceability
            max_danceability_id = track["id"]
        if current_energy > max_energy:
            max_energy = current_energy
            max_energy_id = track["id"]
        if current_duration > max_duration:
            max_duration = current_duration
            max_duration_id = track["id"]

        i += 1

        danceability.append(current_danceability)
        energy.append(current_energy)
        duration.append(current_duration)

        avg_danceability += current_danceability
        avg_energy += current_energy
        avg_duration += current_duration

    avg_duration = avg_duration / i / 1000
    avg_danceability = avg_danceability / i
    avg_energy = avg_energy / i

    features = pd.DataFrame({"Title": title,
                             "Danceability": danceability,
                             "Energy": energy,
                             "Duration": duration
                             })
    features2 = pd.DataFrame({"Stat": ["Average of dance ability", "Average of energy", "Average duration of track"],
                             "Value": [f"{avg_danceability * 100:.2f}%", f"{avg_energy * 100:.2f}%",
                                       f"{(avg_duration // 60):.0f} min {(avg_duration % 60):.0f} s"]
                             })
    return features, features2


# top_genres()
# top_artists()
# top_tracks_avg_popularity()
# top_tracks_era(time_range="long_term")
# top_tracks_features()

app.layout = html.Div(style={'backgroundColor': colors['background']}, children=[
    html.H1(
        children='Spotify statistics',
        style={
            'textAlign': 'center',
            'color': colors['text']
        }
    ),

    html.Button('Top tracks', id='top_tracks', style={'color': 'white'}, n_clicks=0),
    html.Button('Top genres', id='top_genres', style={'color': 'white'}, n_clicks=0),
    html.Button('Top artists', id='top_artists', style={'color': 'white'}, n_clicks=0),
    html.Button('Top eras', id='top_eras', style={'color': 'white'}, n_clicks=0),
    html.Button('Analysis', id='analysis', style={'color': 'white'}, n_clicks=0),
    html.Output(id='output',
                children=''),
    dash_table.DataTable(id='table', fixed_rows={'headers': True, 'data': 0},
                         style_header={'backgroundColor': '#1DB954'}),
    # dcc.Graph(
    #     id='dance_ability',
    #     figure={
    #         'data': [
    #             {'x':  top_tracks_features()['Title'],
    #              'y': top_tracks_features()['Danceability'], 'type': 'bar', 'name': 'HALO'},
    #
    #         ],
    #         'layout': {
    #             'title': 'HALO HLAO',
    #
    #         }
    #     }
    # ),
    html.Div(
        id="graph-container",
        children=[
             dcc.Graph(id='graph')
            ])
])


@app.callback(
    [Output("table", "data"), Output('table', 'columns'), Output('graph-container', 'style')],
    Input('top_tracks', 'n_clicks'),
    Input('top_artists','n_clicks'),
    Input('top_eras', 'n_clicks'),
    Input('top_genres','n_clicks'),
    Input('analysis','n_clicks')

    # State('ScreenName_Input','value')
)
def displayClick(btn1,btn2,btn3,btn4,btn5):
    data = []
    columns = []
    disp = 'none'
    changed_id = [p['prop_id'] for p in dash.callback_context.triggered][0]
    if 'top_tracks' in changed_id:
            output = top_tracks()
            columns = [{'name': col, 'id': col, 'type': 'text', 'presentation': 'markdown'} for col in output.columns if
                   col != "Song_ID" and col != "Artists_ID"]
            data = output.to_dict('records')
    elif 'top_artists' in changed_id:
        output = top_artists()
        columns = [{'name': col, 'id': col, 'type': 'text', 'presentation': 'markdown'} for col in output.columns]
        data = output.to_dict('records')
    elif 'top_genres' in changed_id:
        output = top_genres()
        columns = [{'name': col, 'id': col, 'type': 'text', 'presentation': 'markdown'} for col in output.columns]
        data = output.to_dict('records')
    elif 'top_eras' in changed_id:
        output = top_tracks_era()
        columns = [{'name': col, 'id': col, 'type': 'text', 'presentation': 'markdown'} for col in output.columns]
        data = output.to_dict('records')
    elif 'analysis' in changed_id:
        output = top_tracks_features()[1]
        columns = [{'name': col, 'id': col, 'type': 'text', 'presentation': 'markdown'} for col in output.columns]
        data = output.to_dict('records')
        disp = 'block'
    return data, columns, {'display':disp}

@app.callback(
    Output("graph", 'figure'),
    Input('analysis','n_clicks')
)
def display_bar_chart(btn1):
    figure = make_subplots(rows=2, cols=1,shared_yaxes=True)
    #figure1 = go.Figure[go.Bar()]
    #figure2 = go.Figure[go.Bar()]
    changed_id = [p['prop_id'] for p in dash.callback_context.triggered][0]
    if 'analysis' in changed_id:
        figure.add_trace(go.Bar(x=top_tracks_features()[0].sort_values(by=['Danceability'])["Title"],
                                   y=top_tracks_features()[0].sort_values(by=['Danceability'])["Danceability"],name="Dance ability"))
        figure.add_trace(go.Bar(x=top_tracks_features()[0].sort_values(by=['Energy'])["Title"], y=top_tracks_features()[0].sort_values(by=['Energy'])["Energy"],name="Energy"))
        #figure1 = go.Figure[go.Bar(y=top_tracks_features()[0].sort_values(by=['Danceability'])["Title"],
        #                           x=top_tracks_features()[0].sort_values(by=['Danceability'])["Danceability"])]
        #figure1 = go.bar(top_tracks_features()[0].sort_values(by=['Danceability']), y="Title", x="Danceability",title="Dance ability (in scale 0-1)")
        #figure1.update_traces(marker_color='#1DB954')
        #figure1.update_layout(hoverlabel_bordercolor='white')
        #figure2 = go.Figure[
        #    go.Bar(y=top_tracks_features()[0].sort_values(by=['Energy'])["Title"], x=top_tracks_features()[0].sort_values(by=['Energy'])["Energy"])]
        #figure2 = px.bar(top_tracks_features()[0].sort_values(by=['Energy']), y="Title", x="Energy",title="Energy (in scale 0-1)")
        #figure2.update_traces(marker_color='#1DB954')
        #figure2.update_layout(hoverlabel_bordercolor='white')
    return figure

# @app.callback(Output('graph-container', 'style'), [Input('analysis','n_clicks')])
# def hide_graph(input):
#     if input:
#         return {'display':'block'}
#     return {'display':'none'}

if __name__ == '__main__':
    app.run_server(debug=False)
