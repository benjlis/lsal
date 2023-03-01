import pathlib
import json
import csv

data = pathlib.Path('data')
alist = list(data.iterdir())
alist.sort()
with open('loader.csv', 'w', newline='') as csvfile:
    redactwriter = csv.writer(csvfile, quoting=csv.QUOTE_MINIMAL)
    for a in alist:
        with open(a) as file:
            doc = json.loads(file.read())
            s3_address = doc["task"]["data"]["url"]
            docid = s3_address[s3_address.rfind('/') + 1:\
                               len(s3_address)-4]
            lead = (int(doc["id"]), 
                    doc["completed_by"]["email"],
                    doc["task"]["updated_at"], docid)
            for r in doc["result"]:
                redaction = lead + (r["value"]["start"], 
                                    r["value"]["end"], 
                                    r["value"]["labels"][0])
                redactwriter.writerow(redaction)
