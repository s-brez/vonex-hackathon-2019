import requests
import json
import time


url = "http://localhost:5005/modifylisting"

data = {
    'uid': "l1",
    'offers': ["testmodifyoffer,$120.0", "testmodifyoffer.com,swap"],
    'active': "false",
    'successful': 'true'
    }

headers = {'content-type': 'application/json'}

r = requests.put(url, data=json.dumps(data), headers=headers)

print(r.text)
