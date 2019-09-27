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
        'offers': [{'useremail': 'alice@gmail.com', 'price': '$120.00'}]
    },
    {
        'uid': "l2",
        'itemid': "a1",
        'useremail': 'alice@gmail.com',
        'location': '23 Bourke St Melbourne VIC 3000',
        'active': 'true',
        'successful': 'false',
        'offers': [{'useremail': 'steve@gmail.com', 'price': '$200.00'}]
    },
    {
        'uid': "l3",
        'itemid': "g1",
        'useremail': 'steve@gmail.com',
        'location': '12 Abbotsford St Richmond VIC 3121',
        'active': 'true',
        'successful': 'false',
        'offers': [{'useremail': 'alice@gmail.com', 'price': '$60.00'}]
    },
    {
        'uid': "l4",
        'itemid': "f1",
        'useremail': 'alice@gmail.com',
        'location': '23 Bourke St Melbourne VIC 3000',
        'active': 'true',
        'successful': 'false',
        'offers': [{'useremail': 'steve@gmail.com', 'price': '$150.00'}]
    },
    {
        'uid': "l5",
        'itemid': "b1",
        'useremail': 'steve@gmail.com',
        'location': '12 Abbotsford St Richmond VIC 3121',
        'active': 'true',
        'successful': 'false',
        'offers': [{'useremail': 'alice@gmail.com', 'price': '$75.00'}]
    },
    {
        'uid': "l6",
        'itemid': "c1",
        'useremail': 'alice@gmail.com',
        'location': '23 Bourke St Melbourne VIC 3000',
        'active': 'true',
        'successful': 'false',
        'offers': [{'useremail': 'steve@gmail.com', 'price': '$37.50'}]
    }]

headers = {'content-type': 'application/json'}

for i in data:
    r = requests.post(url, data=json.dumps(i), headers=headers)
    print(r.text)
