import requests
import base64
import json
import time


url = "http://localhost:5005/item"

data = [
    {
        'uid': "h1",
        'name': "Vintage wooden lamp",
        'description': "A peak example of heritage-era lighting.",
        'category': "Homeware",
        'image': "img_url_here"
    },
    {
        'uid': "a1",
        'name': "Kitchenaid mixer",
        'description': "Pre-loved but functional as ever, the classic Kitchenaid.",
        'category': "Appliance",
        'image': "img_url_here"
    },
    {
        'uid': "g1",
        'name': "Car jack, 1 ton",
        'description': "Servicable jack looking for a new home.",
        'category': "Garage",
        'image': "img_url_here"
    },
    {
        'uid': "f1",
        'name': "6-drawer dresser with mirror",
        'description': "Stained rosewood drawer unit with built-in mirror.",
        'category': "Furniture",
        'image': "img_url_here"
    },
    {
        'uid': "b1",
        'name': "A Tale of Two Cities, C. Dickens, 1859",
        'description': "An historical novel by Charles Dickens, set in London and Paris.",
        'category': "Book",
        'image': "img_url_here"
    },
    {
        'uid': "c1",
        'name': "Womens down winter coat",
        'description': "Blue, size M.",
        'category': "Clothing",
        'image': "img_url_here"
    }]

headers = {'content-type': 'application/json'}

for i in data:
    r = requests.post(url, data=json.dumps(i), headers=headers)
    print(r.text)
