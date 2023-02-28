import pathlib
import json

data = pathlib.Path('data')
alist = list(data.iterdir())
alist.sort()
for a in alist:
    with open(a) as file:
        doc = json.loads(file.read())
        atup = (int(doc["id"]), doc["completed_by"]["email"],
                doc["task"]["updated_at"], doc["task"]["data"]["url"])
        print(atup)
        for r in doc["result"]:
            # print(r)
            print(r["value"]["start"], 
                  r["value"]["end"], 
                  r["value"]["labels"][0])