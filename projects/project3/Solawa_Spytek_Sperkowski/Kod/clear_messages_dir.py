import os
import shutil

basefile = os.path.dirname(os.path.abspath(__file__))
root = os.path.join(basefile, "messages","inbox")
for thread in os.listdir(root):
    thread_path = os.path.join(root, thread)
    for file in os.listdir(thread_path):
        if not file.endswith("json"):
            print(os.path.join(thread_path, file))
            #shutil.rmtree(os.path.join(thread_path, file))