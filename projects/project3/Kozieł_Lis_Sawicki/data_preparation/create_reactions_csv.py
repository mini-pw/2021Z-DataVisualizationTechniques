import os
import time
import json
import pandas as pd
from fnmatch import fnmatch
# from dateutil import tz


def create_reactions_csv(person, list_of_paths_to_directories, output_file_path, print_paths=False):
    start = time.time()
    timestamps, reactions = count_in_all_files_2(
        person, list_of_paths_to_directories, print_paths
    )
    if print_paths:
        print(f'All files read in {time.time() - start} second')
        print('Creating data frame...')
    df = pd.DataFrame({'timestamp': timestamps,
                       'reaction': reactions})
    # df['date'] = pd.to_datetime(df['timestamp'], unit='ms', utc=True).dt.tz_convert(tz=tz.tzlocal())
    # df['day_of_the_week'] = df['date'].dt.strftime("%A")
    # df['floored_hour'] = df['date'].dt.strftime("%H")
    df = df.sort_values(by=['timestamp'], ascending=False)
    df.to_csv(output_file_path, index=False)
    if print_paths:
        print('Output file created')
        print(f'Measured time of creating csv_2 : {time.time() - start} seconds')
    return df


def count_in_one_file_2(person, path_to_json, timestamps=None, reactions=None):
    """person means our name and surname on Facebook,
    e.g. person == 'Jan Nowak' """
    if timestamps is None:
        timestamps = []
    if reactions is None:
        reactions = []
    with open(path_to_json, 'r') as j:
        data = json.load(j)
        for message in data['messages']:
            if 'reactions' in message:
                for reaction in message['reactions']:
                    if reaction['actor'].encode('iso-8859-1').decode('utf-8') == person:
                        timestamps.append(message['timestamp_ms'])
                        reactions.append(reaction['reaction'].encode('iso-8859-1').decode('utf-8'))
    return timestamps, reactions


def count_in_all_files_2(person, list_of_paths_to_directories, print_paths=False):
    """every directory should ends with '/'"""
    pattern = "message_*.json"
    timestamps = []
    reactions = []
    i = 0
    for directory in list_of_paths_to_directories:
        for path, subdirs, files in os.walk(directory + 'messages' + os.path.sep):
            for name in files:
                if fnmatch(name, pattern):
                    if print_paths:
                        i += 1
                        print(f'{i}. {os.path.join(path, name)}')
                    timestamps, reactions = count_in_one_file_2(
                        person, os.path.join(path, name), timestamps, reactions
                    )
    return timestamps, reactions