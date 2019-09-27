import requests
import json
import time


url = "http://localhost:5005/item"

data = [
    {
        'uid': "h1",
        'name': "Vintage wooden lamp",
        'description': "A peak example of heritage-era lighting.",
        'category': "Homeware"
    },
    {
        'uid': "a1",
        'name': "Kitchenaid mixer",
        'description': "Pre-loved but functional as ever, the classic Kitchenaid.",
        'category': "Appliance"
    },
    {
        'uid': "g1",
        'name': "Car jack, 1 ton",
        'description': "Servicable jack looking for a new home.",
        'category': "Garage"
    },
    {
        'uid': "f1",
        'name': "6-drawer dresser with mirror",
        'description': "Stained rosewood drawer unit with built-in mirror.",
        'category': "Furniture"
    },
    {
        'uid': "b1",
        'name': "A Tale of Two Cities, C. Dickens, 1859",
        'description': "An historical novel by Charles Dickens, set in London and Paris.",
        'category': "Book"
    },
    {
        'uid': "c1",
        'name': "Womens down winter coat",
        'description': "Blue, size M.",
        'category': "Clothing"
    }]

headers = {'content-type': 'application/json'}

for i in data:
    r = requests.post(url, data=json.dumps(i), headers=headers)
    print(r.text)
