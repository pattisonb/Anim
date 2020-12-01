from markupsafe import escape
from flask import Flask
from flask_restful import Resource, reqparse
import werkzeug
from flask import Flask, request, jsonify
from werkzeug.datastructures import FileStorage
from barcodeScanner import BarcodeScanner
from flask import jsonify
import json
from imageAPI import ImageSearch
import mysql.connector
import re
import os
from os import path
app = Flask(__name__)


@app.route('/foodJSON/')
def foodDict():
    foodJSON = '{ "image": "img.jpg", "foodName": "", "dietLabels": ["Low Carb"], "allergyLabels": ["Dairy Free", "Milk Free", "Peanut Free", "Tree Nut Free", "Soy Free", "Fish Free", "Shellfish Free", "Alcohol Free"], "health": 0, "nutritionalData": [["Energy", "1461.59kcal"], ["Fat", "104.18g"], ["Carbs", "27.64g"], ["Sugars", "15.06g"], ["Protein", "98.16g"], ["Fiber", "3.59g"], ["Sodium", "446.2mg"]], "nutritionalTags": ["High Fat", "Low Fiber", "High Protein", "High Cholesterol"], "unsustainable": ["Palm Oil"] }'
    print("You called /foodJSON/")
    return foodJSON

@app.route("/", methods=["POST", "GET"])
def home_Tester():
    return 'Home Page Works'


@app.route("/barcode", methods=["POST", "GET"])
def process_imageTester():
    parser = reqparse.RequestParser()   
    parser.add_argument("image", type=werkzeug.datastructures.FileStorage, location='files')
    image_file = parser.parse_args(strict=True).get("image", None)
    print(image_file)
    file = FileStorage(image_file)
    if not image_file:
            return "No image sent :("
    print("Image File Recieved")
    file.save("tempLibrary/barcode.jpeg")	
    print("Image saved in directory:" + "tempLibrary/barcode.jpeg")
    foodJSON = BarcodeScanner.getFoodInfoFromBarcode("tempLibrary/barcode.jpeg")
    if type(foodJSON) == int:
        if foodJSON == 1:
            print("Could not read barcode")
            return "Could not read barcode"
        if foodJSON == 2:
            print("Food not found in database")
            return "Food not found in database"
    if foodJSON["image"] == "":
        imageSearch = ImageSearch()
        foodImageLink = imageSearch.getFoodImageLink(foodJSON['foodName'])
        foodJSON['image'] = [foodImageLink]
    with open('tempLibrary/foodInfoFromBarcodeSplit.json', 'w') as json_file:
            json.dump(foodJSON, json_file)
    print("foodJSON: ", foodJSON)
    return foodJSON

@app.route('/foodSearch/<foodName>')
def foodSearch(foodName):
    imageSearch = ImageSearch()
    foodImageLink = imageSearch.getFoodImageLink(foodName)
    foodJSON = BarcodeScanner.getNutrionalDataFromGenericFood("1 "+foodName)
    foodJSON['foodName'] = [foodName]
    foodJSON['image'] = [foodImageLink]
    # foodJSON = str(foodJSON)
    with open('tempLibrary/foodInfoFromBarcodeSplit.json', 'w') as json_file:
            json.dump(foodJSON, json_file)
    return foodJSON


@app.route('/foodSearchImage/')
def foodSearchImage():
    while not path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
            if path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
                break
    with open('tempLibrary/foodInfoFromBarcodeSplit.json') as json_file:
        data = json.load(json_file)
        print(data['image'][0])
        return data['image'][0]

@app.route('/foodSearchName/')
def foodSearchName():
    while not path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
            if path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
                break
    with open('tempLibrary/foodInfoFromBarcodeSplit.json') as json_file:
        data = json.load(json_file)
        print(data['foodName'][0])
        return data['foodName'][0]

@app.route('/foodSearchDietLabels/')
def foodSearchDietLabels():
    while not path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
            if path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
                break
    with open('tempLibrary/foodInfoFromBarcodeSplit.json') as json_file:
        data = json.load(json_file)
        result = ""
        for item in data['dietLabels']:
            result += item
            result += ", "
        print(result[:len(result)-2])
        return result[:len(result)-2]

@app.route('/foodSearchAllergyLabels/')
def foodSearchAllergyLabels():
    while not path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
            if path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
                break
    with open('tempLibrary/foodInfoFromBarcodeSplit.json') as json_file:
        data = json.load(json_file)
        result = ""
        for item in data['allergyLabels']:
            result += item
            result += ", "
        print("AllergyLabels: ", result[:len(result)-2])
        return result[:len(result)-2]

@app.route('/foodSearchHealth/')
def foodSearchHealth():
    while not path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
            if path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
                break
    with open('tempLibrary/foodInfoFromBarcodeSplit.json') as json_file:
        data = json.load(json_file)
        health = str(data['health'])
        if health[0] == "[":
            health = health[1:len(health)-1]
        print("Health: ", health)
        return health

@app.route('/foodSearchNutritionalTags/')
def foodSearchNutritionalTags():
    while not path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
            if path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
                break
    with open('tempLibrary/foodInfoFromBarcodeSplit.json') as json_file:
        data = json.load(json_file)
        result = ""
        for item in data['nutritionalTags']:
            result += item
            result += ", "
        print(result[:len(result)-2])
        return result[:len(result)-2]

@app.route('/foodSearchUnsustainable/')
def foodSearchUnsustainable():
    while not path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
            if path.exists('tempLibrary/foodInfoFromBarcodeSplit.json'):
                break
    with open('tempLibrary/foodInfoFromBarcodeSplit.json') as json_file:
            data = json.load(json_file)
    os.remove('tempLibrary/foodInfoFromBarcodeSplit.json')
    print(data['unsustainable'])
    print("Removed File: tempLibrary/foodInfoFromBarcodeSplit.json")
    if data['unsustainable'] == []:
        return "Sustainable"
    else:
        result = ""
        for item in data['unsustainable']:
            result += item
            result += ", "
        print("Unsustainable: ", result[:len(result)-2])
        return result[:len(result)-2]



if __name__ == "__main__":
    app.run(host='0.0.0.0')
