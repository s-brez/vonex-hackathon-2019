import requests
import base64
import json
import time


url = "http://localhost:5005/modifyuser"

data = {
    'email': "alice@gmail.com",
    'saveditems': ["modtest", "a1"],
    'listings': ["modtest", "l5", "l6"],
    'rating': '9999'
    }

headers = {'content-type': 'application/json'}

r = requests.put(url, data=json.dumps(data), headers=headers)

print(r.text)
