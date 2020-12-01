class healthCalculator:
    def determineHealthiness(nutritionalData, ingredients):
        CALORIES_DIAL    = [ ]
        SUGAR_DIAL       = [ 27, 6]#g*
        FAT_DIAL         = [ 50, 4]#g*
        SATFAT_DIAL      = [  2, 1]#g
        CARB_DIAL        = [100, 2]#g
        CHOLESTEROL_DIAL = [ 15, 5]#mg*
        SODIUM_DIAL      = [100,50]#mg*
        PROTEIN_DIAL     = [ 50,10]#g
        FIBER_DIAL       = [ 25, 6]#g
        score = 7.5
        nutrientTags = []

        #loops through the length of nutritionalData list
        for i in range(len(nutritionalData)):
            #Sugar contents
            if nutritionalData[i][0] == "Sugars" or nutritionalData[i][0] == "SUGAR":
                if nutritionalData[i][1] > SUGAR_DIAL[0]:
                    ratio = nutritionalData[i][1] * .1
                    score -= ratio
                    nutrientTags.append("High Sugar")
                elif nutritionalData[i][1] < SUGAR_DIAL[1]:
                    nutrientTags.append("Low Sugar")

            #Fat contents
            elif nutritionalData[i][0] == "Fat" or nutritionalData[i][0] == "FAT":
                if nutritionalData[i][1] > FAT_DIAL[0]:
                    nutrientTags.append("High Fat")
                    score -= 1
                elif nutritionalData[i][1] < FAT_DIAL[1]:
                    nutrientTags.append("Low Fat")
                    score += .5

            #Saturdated Fat contents
            elif nutritionalData[i][0] == "Saturated" or nutritionalData[i][0] == "FASAT":
                if nutritionalData[i][1] > SATFAT_DIAL[0]:
                    score -= 1
                    nutrientTags.append("High Saturated Fat")
                elif nutritionalData[i][1] <= FAT_DIAL[1]:
                    score += 2

            #Carb contents
            elif nutritionalData[i][0] == "Carbs" or nutritionalData[i][0] == "CHOCDF":
                if nutritionalData[i][1] > CARB_DIAL[0]:
                    ratio = nutritionalData[i][1] * .01
                    score -= ratio
                    nutrientTags.append("High Carbs")
                elif nutritionalData[i][1] < CARB_DIAL[1]:
                    nutrientTags.append("Low Carbs")

            #Cholesterol contents
            elif nutritionalData[i][0] == "Cholesterol" or nutritionalData[i][0] == "CHOLE":
                if nutritionalData[i][1] > CHOLESTEROL_DIAL[0]:
                    score -= 1
                    nutrientTags.append("High Cholesterol")
                elif nutritionalData[i][1] < CHOLESTEROL_DIAL[1]:
                    nutrientTags.append("Low Cholesterol")

            #Sodium contents
            elif nutritionalData[i][0] == "Sodium" or nutritionalData[i][0] == "NA":
                if nutritionalData[i][1] > SODIUM_DIAL[0]:
                    score -= 2
                    nutrientTags.append("High Sodium")
                elif nutritionalData[i][1] == SODIUM_DIAL[1]:
                    nutrientTags.append("Low Sodium")
                    score += 2

            #Protein contents
            elif nutritionalData[i][0] == "Protein" or nutritionalData[i][0] == "PROCNT":
                if nutritionalData[i][1] > PROTEIN_DIAL[0]:
                    score += 3
                    nutrientTags.append("High Protein")
                elif nutritionalData[i][1] < PROTEIN_DIAL[1]:
                    nutrientTags.append("Low Protein")

            #Fiber contents
            elif nutritionalData[i][0] == "Fiber" or nutritionalData[i][0] == "FIBTG":
                if nutritionalData[i][1] > FIBER_DIAL[0]:
                    score += 2
                    nutrientTags.append("High Fiber")
                elif nutritionalData[i][1] < FIBER_DIAL[1]:
                    nutrientTags.append("Low Fiber")

        if "Fake" in ingredients or "Artifical" in ingredients:
            nutrientTags.append("Artifical Ingredients")
            score -= 3
        if "Oil" in ingredients:
            nutrientTags.append("Oil Ingredients")
            score -= 1
        if "Monosodium Glutamate" in ingredients:
            score -= 3
            nutrientTags.append("MSG")
        if "Corn Syrup" in ingredients or "Palm Oil" in ingredients:
            nutrientTags.append("Processed Ingredients")
            score -= 2
        if "Sodium Benzoate" in ingredients or "Potassium Benzoate" in ingredients or "Butylated Hydroxyanisole" in ingredients or "Sodium Nitrates" in ingredients or "Sodium Nitrites" in ingredients:
            nutrientTags.append("Bad Preservatives")
            score -= 3

        if score < 0:
            score = 0
        elif score > 10:
            score = 10
        round(score, 1)
        nutrientTags.insert(0, score)
        return nutrientTags