import requests
import json


url = "http://localhost:5005/user"

data = {
    'firstname': 'Alice',
    'lastname': 'Green',
    'email': 'agreen@gmail.com',
    'password': 'password'}

headers = {'Content-type': 'application/json'}

r = requests.post(url, data=json.dumps(data), headers=headers)

print(r.text)
