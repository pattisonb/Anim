from pyzbar.pyzbar import decode
import os.path
from os import path
import json
from PIL import Image
import requests
from queryParser import queryParser
from barcodeParser import barcodeParser
from queryParser import queryParser

class BarcodeScanner:
    def getBarcodeNum(imagePath):
        while not path.exists(imagePath):
            print(path.exists(imagePath))
            if path.exists(imagePath):
                break
        img = Image.open(imagePath)
        result = decode(img)
        os.remove(imagePath)
        if result == []:
            return 1
        for i in result:
            return(i.data.decode("utf-8"))



    # Application Key: b9dcef92986d590cb9ab55d2322295sudde
    # Application ID: be1bf95b
    def getFoodInfoFromBarcode(imagePath):
        barcodeNum = BarcodeScanner.getBarcodeNum(imagePath)
        if barcodeNum == 1:
            return 1
        parameters = {"upc": barcodeNum, 
                "app_id": "be1bf95b",
                "app_key": "b9dcef92986d590cb9ab55d2322295de"}

        response = requests.get("https://api.edamam.com/api/food-database/v2/parser?", params=parameters)
        data = response.json()
        if "error" in data: # Could not find Barcode in database
            return 2
        hints = data['hints']
        food = hints[0]
        foodName = food['food']
        foodName = foodName['label']
        # print(data)
        with open('tempLibrary/foodInfoFromBarcode.json', 'w') as json_file:
            json.dump(data, json_file)
        parser = barcodeParser()
        result = parser.barcodeJsonHandler("tempLibrary/foodInfoFromBarcode.json")
        os.remove("tempLibrary/foodInfoFromBarcode.json")
        return result
        

    # Application Key: 0aaf2a4b9bbbf324c57b80C1473720921
    # Application ID: a689984d
    def getNutrionalDataFromGenericFood(food):
        parameters = {"ingr": food, 
                "app_id": "a689984d",
                "app_key": "0aaf2a4b9bbbf324c57b801473720921"}

        response = requests.get("https://api.edamam.com/api/nutrition-data?", params=parameters)
        
        data = response.json()
        with open('tempLibrary/foodInfoFromGenericSearch.json', 'w') as json_file:
            json.dump(data, json_file)
        parser = queryParser()
        result = parser.queryJsonHandler("tempLibrary/foodInfoFromGenericSearch.json")
        os.remove("tempLibrary/foodInfoFromGenericSearch.json")
        return result




