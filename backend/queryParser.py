import json
import re
from healthAlgo import healthCalculator
from sustainableAlgo import sustainabilityCalculator

class queryParser:
    def queryJsonHandler(self, jsonName):
        #json parcer
        with open(jsonName) as file:
            foodDetails = json.load(file)
        
        #Creates a list filled with allergy info
        try:
            allergyLabels = queryParser.getAllergyData(self, foodDetails)
        except:
            allergyLabels = []
        #Creates a list of diet info
        try:
            dietLabels = queryParser.getDietData(self, foodDetails)
        except:
            dietLabels = []
        #Creates a list filled with nutrition facts
        try:
            nutritionalData = queryParser.getNutritionalData(self, foodDetails)
        except:
            nutritionalData = []
        #Creates a list filled with ingredients
        try:
            ingredients = queryParser.getIngredients(self, foodDetails)
        except:
            ingredients = []

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
        foodInfoDict = queryParser.formatDictionary(self, dietLabels, allergyLabels, nutritionalData, nutritionalTags, unsustainableIngredients)
        return foodInfoDict


    def getAllergyData(self, foodDetails):
        allergyData = []
        #loops through list of allergies
        for i in foodDetails['healthLabels']: 
            allergyData.append(i.lower().replace('_', ' ').title())
        return allergyData


    def getDietData(self, foodDetails):
        dietData = []
        #loops through list of diets
        for i in foodDetails['dietLabels']: 
            dietData.append(i.lower().replace('_', ' ').title())
        return dietData


    def getNutritionalData(self, foodDetails):
        nutritionalData = []
        try:
            servingSize = foodDetails['yield'] #takes into account serving size
        except:
            servingSize = 1
        #loops through list of nutrients
        for nutrient in foodDetails['totalNutrients']:
            nutritionalData.append(
                [foodDetails['totalNutrients'][nutrient]['label'], 
                round(foodDetails['totalNutrients'][nutrient]['quantity']/servingSize, 2),
                foodDetails['totalNutrients'][nutrient]['unit']])
        return nutritionalData

    def getIngredients(self, foodDetails):
        string = ""
        #
        for index, text in enumerate(foodDetails['ingredients']):
            string += text['text'] + " "
        ingredients = re.sub('[\W_]+', ' ', string)
        ingredients = ingredients.lower().title()
        return ingredients

    def formatDictionary(self, dietLabels, allergyLabels, nutritionalData, nutritionalTags, unsustainableIngredients):
        foodInfoDict = {}
        foodInfoDict['image'] = ""
        foodInfoDict['foodName'] = ""
        foodInfoDict['dietLabels'] = dietLabels
        foodInfoDict['allergyLabels'] = allergyLabels
        foodInfoDict['health'] = nutritionalTags.pop(0)
        foodInfoDict['nutritionalTags'] = nutritionalTags
        foodInfoDict['unsustainable'] = unsustainableIngredients
        return foodInfoDict


"""
    def dummyQueryFunc(self):
        #json parcer
        with open('dummyFile/edamamTest.json') as file:
            foodDetails = json.load(file)
        
        #Creates a list filled with allergy info
        allergyLabels = queryParser.getAllergyData(self, foodDetails)
        #Creates a list of diet info
        dietLabels = queryParser.getDietData(self, foodDetails)
        #Creates a list filled with nutrition facts
        nutritionalData = queryParser.getNutritionalData(self, foodDetails)
        #Creates a list filled with ingredients
        ingredients = queryParser.getIngredients(self, foodDetails)

        #Algorithm to determine healthiness
        nutritionalTags = healthCalculator.determineHealthiness(nutritionalData, ingredients)
        #Algorithm to determine sustainability
        unsustainableIngredients = sustainabilityCalculator.determineSustainability(ingredients)
        #Format Dictionary 
        foodInfoDict = queryParser.formatDictionary(self, dietLabels, allergyLabels, nutritionalData, nutritionalTags, unsustainableIngredients)
        print(foodInfoDict)
        return foodInfoDict
    
query = queryParser()

query.dummyQueryFunc()
"""