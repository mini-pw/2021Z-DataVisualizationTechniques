from data_preparation.create_messages_csv import create_messages_csv
from data_preparation.create_reactions_csv import create_reactions_csv
from data_preparation.create_notifications_csv import create_notifications_csv
import emoji
import os


def main():
    # Create your csv files
    # a list to all directories created by facebook
    # sometimes it is only one directory, sometimes more - make sure to put it in a list
    # e.g. list_of_paths_to_directories = ['path/facebook-kubalis186-1/', 'path/facebook-kubalis186-2/']
    name = ''
    surname = ''
    list_of_paths_to_directories = []

    # a file with all emojis - maybe it can be used in R
    with open('data/all_emoji.txt', 'w') as f:
        for key in emoji.UNICODE_EMOJI.keys():
            f.write(key + '\n')

    create_messages_csv(
        name + ' ' + surname,
        list_of_paths_to_directories,
        os.path.join('data', 'messages_' + name + '_' + surname + '.csv'),
        True
    )

    # we made this function, but we didn't use this data in our app
    create_reactions_csv(
        name + ' ' + surname,
        list_of_paths_to_directories,
        os.path.join('data', 'reactions_' + name + '_' + surname + '.csv'),
        True
    )

    create_notifications_csv(list_of_paths_to_directories,
                             os.path.join('data', 'notifications_' + name + '_' + surname + '.csv'))


if __name__ == '__main__':
    main()
