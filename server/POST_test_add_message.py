from datetime import datetime
import time
import requests
import json


url = "http://localhost:5005/message"

data = [
    {
        'time': int(time.mktime(datetime.utcnow().timetuple())) - 10000,
        'to': 'alice@gmail.com',
        'from': 'steve@gmail.com',
        'text': "Hi Alice, I am interested in your Vintage Lamp item, would you consider a trade for my toaster oven?"
    },
    {
        'time': int(time.mktime(datetime.utcnow().timetuple())) - 5000,
        'to': 'steve@gmail.com',
        'from': 'alice@gmail.com',
        'text': "Steve, I might like your toaster oven, could you please list it here on Up-Cycle via 'Add Listing' so I can have a little more info?"
    }]

headers = {'content-type': 'application/json'}

for i in data:
    r = requests.post(url, data=json.dumps(i), headers=headers)
    print(r.text)
