import pandas as pd
import time
import os
import json
import emoji
from dateutil import tz
from fnmatch import fnmatch


def create_messages_csv(person, list_of_paths_to_directories, output_file_path, print_paths=False):
    start = time.time()
    timestamps, lengths, emojis = count_in_all_files(
        person, list_of_paths_to_directories, print_paths
    )
    if print_paths:
        print(f'All files read in {time.time() - start} second')
        print('Creating data frame...')
    df = pd.DataFrame({'timestamp': timestamps,
                       'length': lengths,
                       'emojis': emojis})
    df['date'] = pd.to_datetime(df['timestamp'], unit='ms', utc=True).dt.tz_convert(tz=tz.tzlocal())
    df['day_of_the_week'] = df['date'].dt.strftime("%A")
    df['floored_hour'] = df['date'].dt.strftime("%H")
    df = df.sort_values(by=['timestamp'], ascending=False)
    df.to_csv(output_file_path, index=False)
    if print_paths:
        print('Output file created')
        print(f'Measured time of creating csv : {time.time() - start} seconds')
    return df


def count_in_all_files(person, list_of_paths_to_directories, print_paths=False):
    """every directory should ends with '/'"""
    pattern = "message_*.json"
    timestamps = []
    lengths = []
    emojis = []
    i = 0
    for directory in list_of_paths_to_directories:
        for path, subdirs, files in os.walk(directory + 'messages' + os.path.sep):
            for name in files:
                if fnmatch(name, pattern):
                    if print_paths:
                        i += 1
                        print(f'{i}. {os.path.join(path, name)}')
                    timestamps, lengths, emojis = count_in_one_file(
                        person, os.path.join(path, name), timestamps, lengths, emojis
                    )
    return timestamps, lengths, emojis


def count_in_one_file(person, path_to_json, timestamps=None, lengths=None, emojis=None):
    """person means our name and surname on Facebook,
    e.g. person == 'Jan Nowak' """
    if lengths is None:
        lengths = []
    if timestamps is None:
        timestamps = []
    if emojis is None:
        emojis = []
    with open(path_to_json, 'r') as j:
        data = json.load(j)
        for message in data['messages']:
            if message['sender_name'].encode('iso-8859-1').decode('utf-8') != person:
                continue
            if 'content' in message:
                timestamps.append(message['timestamp_ms'])
                msg = message['content'].encode('iso-8859-1').decode('utf-8')
                lengths.append(len(msg))
                e = ''
                for key in emoji.UNICODE_EMOJI.keys():
                    if key in msg:
                        e += key
                emojis.append(e)
    return timestamps, lengths, emojis
