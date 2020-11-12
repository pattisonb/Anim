import json

class sustainableAlgo:

    def determineHealthiness(nutritionalData):
        SUGAR_DIAL       = 25
        FAT_DIAL         = 30
        CARB_DIAL        = 5
        CHOLESTEROL_DIAL = 15
        SODIUM_DIAL      = 60
        score = 1000

        for i in range(len(nutritionalData)):
            #Sugar contents
            if nutritionalData[i][0] == "Sugars":
                if nutritionalData[i][1] > SUGAR_DIAL:
                    ratio = nutritionalData[i][1] - SUGAR_DIAL
                    score -= ratio

            #Fat contents
            elif nutritionalData[i][0] == "Fat":
                if nutritionalData[i][1] > FAT_DIAL:
                    ratio = nutritionalData[i][1] - FAT_DIAL
                    score -= ratio

            #Carb contents
            elif nutritionalData[i][0] == "Carbs":
                if nutritionalData[i][1] > CARB_DIAL:
                    ratio = nutritionalData[i][1] - CARB_DIAL
                    score -= ratio

            #Cholesterol contents
            elif nutritionalData[i][0] == "Cholesterol":
                if nutritionalData[i][1] > CHOLESTEROL_DIAL:
                    ratio = nutritionalData[i][1] - CHOLESTEROL_DIAL
                    score -= ratio

            #Sodium contents
            elif nutritionalData[i][0] == "Sodium":
                if nutritionalData[i][1] > SODIUM_DIAL:
                    ratio = nutritionalData[i][1] - SODIUM_DIAL
                    score -= ratio
        return score


    def getAllergyData(foodDetails):
        allergyData = []
        #loops through list of allergies
        for i in foodDetails['healthLabels']: 
            allergyData.append(i.lower().replace('_', ' ').title())
        return allergyData


    def getDietData(foodDetails):
        dietData = []
        #loops through list of diets
        for i in foodDetails['dietLabels']: 
            dietData.append(i.lower().replace('_', ' ').title())
        return dietData


    def getNutritionalData(foodDetails):
        nutritionalData = []
        servingSize = foodDetails['yield'] #takes into account serving size
        #loops through list of nutrients
        for nutrient in foodDetails['totalNutrients']:
            nutritionalData.append(
                [foodDetails['totalNutrients'][nutrient]['label'], 
                round(foodDetails['totalNutrients'][nutrient]['quantity']/servingSize, 2),
                foodDetails['totalNutrients'][nutrient]['unit']])
        return nutritionalData


    def jsonHandler(jsonName):
        #json parcer
        with open(jsonName) as file:
            foodDetails = json.load(file)
        
        #Creates a list filled with allergy info
        allergyData = sustainableAlgo.getAllergyData(foodDetails)

        #Creates a list of diet info
        dietData = sustainableAlgo.getDietData(foodDetails)

        #Creates a list filled with nutrition facts
        nutritionalData = sustainableAlgo.getNutritionalData(foodDetails)

        #Algorithm to determine healthiness
        healthScore = sustainableAlgo.determineHealthiness(nutritionalData)

        return nutritionalData








#######################################################################################################
"""
    def dummyFunc():
        with open('backend/dummyFile/edamamTest.json') as file:
            foodDetails = json.load(file)

        #Creates a list of allergy info
        allergyData = sustainableAlgo.getAllergyData(foodDetails)
        print(allergyData)

        #Creates a list of diet info
        dietData = sustainableAlgo.getDietData(foodDetails)
        print(dietData)

        #Creates a list of nutrition facts
        nutritionalData = sustainableAlgo.getNutritionalData(foodDetails)
        #for i in range(len(nutritionalData)):
            #print(nutritionalData[i][0], ":", nutritionalData[i][1], nutritionalData[i][2])
        print(nutritionalData)
        
        #Algorithm to determine healthiness
        healthScore = sustainableAlgo.determineHealthiness(nutritionalData)
        print("Healthiness Score:", healthScore)

sustainableAlgo.dummyFunc()
"""