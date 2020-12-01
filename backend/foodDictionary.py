import json
# Food that is sustainable
foodInfoDict = '{ "image": "https://www.edamam.com/food-img/50f/50f43b6a50f5f6da409801f7faea72ca.jpg", "foodName": "BREAKFAST BISCUITS", "dietLabels": "Vegan, Vegetarian, Paleo", "health": "9", "sugar": "3 Grams", "fat": "8 Grams", "carbs": "7 Grams", "protein": "[26 Grams", "sustainable": "", "healthLabels": "Low Sugar, Low Carb, High Protein" }'



# parse x:
y = json.loads(foodInfoDict)

# the result is a Python dictionary:
print(y["image"])

