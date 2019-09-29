import requests
import json


url = "http://localhost:5005/listing"

data = [
    {
        'uid': "l1",
        'itemid': "h1",
        'useremail': 'steve@gmail.com',
        'location': '12 Abbotsford St Richmond VIC 3121',
        'active': 'true',
        'successful': 'false',
        'offers': ['alice@gmail.com,$120.00', 'alice@gmail.com,swap']
    },
    {
        'uid': "l2",
        'itemid': "a1",
        'useremail': 'alice@gmail.com',
        'location': '23 Bourke St Melbourne VIC 3000',
        'active': 'true',
        'successful': 'false',
        'offers': ['steve@gmail.com,$200.00', 'steve@gmail.com,swap']
    },
    {
        'uid': "l3",
        'itemid': "g1",
        'useremail': 'steve@gmail.com',
        'location': '12 Abbotsford St Richmond VIC 3121',
        'active': 'true',
        'successful': 'false',
        'offers': ['alice@gmail.com,$60.00', 'alice@gmail.com,swap']
    },
    {
        'uid': "l4",
        'itemid': "f1",
        'useremail': 'alice@gmail.com',
        'location': '23 Bourke St Melbourne VIC 3000',
        'active': 'true',
        'successful': 'false',
        'offers': ['steve@gmail.com,$150.00', 'steve@gmail.com,swap']
    },
    {
        'uid': "l5",
        'itemid': "b1",
        'useremail': 'steve@gmail.com',
        'location': '12 Abbotsford St Richmond VIC 3121',
        'active': 'true',
        'successful': 'false',
        'offers': ['alice@gmail.com,$75.00', 'steve@gmail.com,swap']
    },
    {
        'uid': "l6",
        'itemid': "c1",
        'useremail': 'alice@gmail.com',
        'location': '23 Bourke St Melbourne VIC 3000',
        'active': 'true',
        'successful': 'false',
        'offers': ['steve@gmail.com,$37.50', 'steve@gmail.com,swap']
    }]

headers = {'content-type': 'application/json'}

for i in data:
    r = requests.post(url, data=json.dumps(i), headers=headers)
    print(r.text)
