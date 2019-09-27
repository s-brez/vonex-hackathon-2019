import requests
import json


url = "http://localhost:5005/user"

data = [
    {
        'email': 'steve@gmail.com',
        'firstname': 'Steve',
        'lastname': 'Smith',
        'password': 'Password',
        'picker': 'true',
        'packer': 'true',
        'fb': '/ssmith_fb_url',
        'insta': '/ssmith_fb_url',
        'saveditems': ["h1", "a1"],
        'listings': ["l4", "l5", "l6"]
    },
    {
        'email': 'alice@gmail.com',
        'firstname': 'Alice',
        'lastname': 'Green',
        'password': 'password123',
        'picker': 'false',
        'packer': 'true',
        'fb': '/agreen_fb_url',
        'insta': '/agreen_fb_url',
        'saveditems': ["f1", "b1"],
        'listings': ["l1", "l2", "l3"]
    }]

headers = {'content-type': 'application/json'}

for i in data:
    r = requests.post(url, data=json.dumps(i), headers=headers)

print(r.text)
