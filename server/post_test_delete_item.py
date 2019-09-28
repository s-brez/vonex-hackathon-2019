import requests
import base64
import json
import time


url = "http://localhost:5005/deleteitem"

data = {'uid': "a1"}

headers = {'content-type': 'application/json'}

r = requests.delete(url, data=json.dumps(data), headers=headers)

print(r.text)
