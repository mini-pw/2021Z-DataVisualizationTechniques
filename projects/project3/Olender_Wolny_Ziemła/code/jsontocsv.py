import json
import numpy as np
import pandas as pd
import os
from pandas import DataFrame as df

authkey = "BQAV3iDFLUAUxN5RUn-7Te0gUYFch3Q9Rcf5t4L3M12CvjACde36_4wK0TtT3uEEUWBI10fzfAkmDZMupRBRFXgrAxOV9PgXxyOXOZwFaQlC2-WdjVhFLn5k44XQIdRuMdKySizLO_J2XMFpZ1kwR0Bm5-Lh43rZfCfQ_cWfDo_nJEKup4T6sb4QK59EOQvCOObC1CfFhkciofC73j9gV5rE4v-QzSPhEe3L3VXR4teDnILbJFGNLJ0r1oQD02fO7-1kFlJQb0Xt0w"
command1 = 'curl -X "GET" "https://api.spotify.com/v1/audio-features/'
# command + id + command2 + authkey
command2 = '" -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer '


def command(i): return command1 + i + command2 + authkey + '"'


dtypes = np.dtype([
    ('id', str),
    ('name', str),
    ('img', str),
    ('link', str),
    ('danceability', float),
    ('energy', float),
    ('loudness', float),
    ('speechiness', float),
    ('acousticness', float),
    ('instrumentalness', float),
    ('liveness', float),
    ('valence', float),
    ('tempo', float),
    ('duration_ms', float),
    ('author', str),
    ('album', str),
])
data = np.empty(0, dtype=dtypes)
frame = pd.DataFrame(data)

ppl = ["p", "u", "z"]
i = 0

for person in ppl:
    jsonfile = person + ".json"
    parsed = None
    with open(jsonfile) as f:
        parsed = json.load(f)
    tracks = parsed["tracks"]["items"]
    for trackobj in tracks:
        track = trackobj["track"]

        img = track["album"]["images"][1]["url"]
        name = track["name"]
        identifier = track["id"]
        link = track["preview_url"]
        print(i+1, "/", "300")
        res = os.popen(command(identifier)).read()
        information = json.loads(res)

        danceability = information["danceability"]
        energy = information["energy"]
        loudness = information["loudness"]
        speechiness = information["speechiness"]
        acousticness = information["acousticness"]
        instrumentalness = information["instrumentalness"]
        liveness = information["liveness"]
        valence = information["valence"]
        tempo = information["tempo"]
        album = track["album"]["name"]
        author = track["album"]["artists"][0]["name"]
        duration_ms = information["duration_ms"]

        line = {"id": identifier, "name": name,
                "img": img, "link": link, "whose": person,
                "danceability": danceability,
                "energy": energy,
                "loudness": loudness,
                "speechiness": speechiness,
                "acousticness": acousticness,
                "instrumentalness": instrumentalness,
                "liveness": liveness,
                "valence": valence,
                "tempo": tempo,
                "duration_ms": duration_ms,
                "author": author,
                "album": album
                }

        frame = frame.append(line, ignore_index=True)
        i += 1

print(frame)

frame.to_csv("data.csv")
