import requests, json

class ImageSearch:
    def getFoodImageLink(self, foodName):
        URL = 'https://serpapi.com/search.json'

        PARAMS = {
        'client_id': "ufxf-XmmmOnWPejqRbGGvTkCcsTNLpOiPOWPrwKUSiM",   
        'q': foodName,
        'tbm': "isch",
        "api_key": "8e4884e7ee3f551069ef4ddd46a0cae9f7086fffe01a9e57d507e9b269ba1e05"
        }


        response = requests.get(url = URL, params = PARAMS)
        data = response.json()
        firstResult = data["images_results"]
        firstResult = firstResult[0]
        originalPhoto = firstResult['original']
        return originalPhoto



