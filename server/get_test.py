import requests
import json


url = "http://localhost:5005/user"

data = 'agreen@gmail.com'

headers = {'Content-type': 'application/json'}

r = requests.get(url + "/" + data, data=json.dumps(data), headers=headers)

print(r.text)
