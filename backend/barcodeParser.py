import json
from healthAlgo import healthCalculator
from sustainableAlgo import sustainabilityCalculator

class barcodeParser:
    def barcodeJsonHandler(self, jsonName):
        #json parcer
        with open(jsonName) as file:
            foodDetails = json.load(file)

        foodInfoDict = {}

        #determines the name of the food
        try:
            foodName = [foodDetails['hints'][0]['food']['label'].lower().title()]
        except:
            foodName = [""]
        #Determines the image of the food
        try:
            image = [foodDetails['hints'][0]['food']['image']]
        except:
            image = [""]
        #Creates a list filled with nutrition facts
        try:
            nutritionalData = barcodeParser.getNutritionalData(self, foodDetails)
        except:
            nutritionalData = ["No Nutritional Data Found"]
        #Creates a list filled with ingredients
        try:
            ingredients = barcodeParser.getIngredients(self, foodDetails)
        except:
            ingredients = ["No Ingedients Found"]

        #Algorithm to determine healthiness
        try:
            nutritionalTags = healthCalculator.determineHealthiness(nutritionalData, ingredients)
        except:
            nutritionalTags = []
        #Algorithm to determine sustainability
        try:
            unsustainableIngredients = sustainabilityCalculator.determineSustainability(ingredients)
        except:
            unsustainableIngredients = []
        #Format Dictionary 
        foodInfoDict = barcodeParser.formatDictionary(self, image, foodName, nutritionalData, nutritionalTags, unsustainableIngredients)
        return foodInfoDict

    def getNutritionalData(self, foodDetails):
        nutritionalData = []
        #loops through list of nutrients
        for nutrient in foodDetails['hints'][0]['food']['nutrients']:
            nutritionalData.append(
                [nutrient, 
                round(foodDetails['hints'][0]['food']['nutrients'][nutrient], 2)])
        return nutritionalData

    def getIngredients(self, foodDetails):
        bad_chars = ['(', ')', '[', ']', ';', '.']
        ingredients = foodDetails['hints'][0]['food']['foodContentsLabel'].lower().title()
        for char in bad_chars :
            ingredients = ingredients.replace(char, '')

        return ingredients

    def formatDictionary(self, image, foodName, nutritionalData, nutritionalTags, unsustainableIngredients):
        foodInfoDict = {}
        foodInfoDict['image'] = image
        foodInfoDict['foodName'] = foodName
        foodInfoDict['dietLabels'] = []
        foodInfoDict['allergyLabels'] = []
        foodInfoDict['health'] = nutritionalTags.pop(0)
        foodInfoDict['nutritionalTags'] = nutritionalTags
        foodInfoDict['unsustainable'] = unsustainableIngredients
        return foodInfoDict


"""
    def dummyBarcodeFunc(self):
        #json parcer
        with open('dummyFile/barcodeResult.json') as file:
            foodDetails = json.load(file)

        #determines the name of the food
        foodName = foodDetails['hints'][0]['food']['label'].lower().title()
        #determines the image of the food
        image = foodDetails['hints'][0]['food']['image']
        #Creates a list filled with nutrition facts
        nutritionalData = barcodeParser.getNutritionalData(self, foodDetails)
        #Creates a list filled with ingredients
        ingredients = barcodeParser.getIngredients(self, foodDetails)

        #Algorithm to determine healthiness
        nutritionalTags = healthCalculator.determineHealthiness(nutritionalData, ingredients, "Barcode")
        #Algorithm to determine sustainability
        unsustainableIngredients = sustainabilityCalculator.determineSustainability(ingredients)
        #Format Dictionary 
        foodInfoDict = barcodeParser.formatDictionary(self, image, foodName, nutritionalData, nutritionalTags, unsustainableIngredients)
        print(foodInfoDict)
        return foodInfoDict

barcode = barcodeParser()

barcode.dummyBarcodeFunc()
"""