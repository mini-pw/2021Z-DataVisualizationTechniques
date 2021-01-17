import json
import os
import pandas as pd
import time
from dateutil import tz


def create_notifications_csv(list_of_paths_to_directories, output_file_path, print_paths=False):
    start = time.time()
    timestamps, unread = count_notifications(list_of_paths_to_directories)
    if print_paths:
        print(f'All files read in {time.time() - start} second')
        print('Creating data frame...')
    df = pd.DataFrame({'timestamp': timestamps,
                       'unread': unread})
    df['date'] = pd.to_datetime(df['timestamp'], unit='s', utc=True).dt.tz_convert(tz=tz.tzlocal())
    df['day_of_the_week'] = df['date'].dt.strftime("%A")
    df['floored_hour'] = df['date'].dt.strftime("%H")
    df = df.sort_values(by=['timestamp'], ascending=False)
    df.to_csv(output_file_path, index=False)
    if print_paths:
        print('Output file created')
        print(f'Measured time of creating csv : {time.time() - start} seconds')
    return df


def count_notifications(list_of_paths_to_directories):
    path = os.path.join('about_you', 'notifications.json')
    timestamps = []
    unread = []
    for directory in list_of_paths_to_directories:
        json_dir = os.path.join(directory, path)
        if not os.path.exists(json_dir):
            continue
        with open(json_dir, 'r') as f:
            data = json.load(f)
            for notification in data['notifications']:
                timestamps.append(notification['timestamp'])
                unread.append(notification['unread'])
    return timestamps, unread
