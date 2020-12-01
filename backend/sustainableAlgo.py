import json

class sustainabilityCalculator:
    def determineSustainability(ingredients):
        badIngredients = ["Mineral Oil", "Palm Oil", "Palm Kernel Oil", "Vegetable Oil", "Vegetable Fat", "Palm Kernel", "Palm Kernel Oil", "Palm Fruit Oil", "Palmate", "Palmitate", "Palmolein",
        "Glyceryl", "Stearate", "Stearic Acid", "Elaeis Guineensis", "Palmitic Acid", "Palm Stearine", "Palmitoyl Oxostearamide", "Palmitoyl Tetrapeptide-3", "Sodium Laureth Sulfate", 
        "Sodium Lauryl Sulfate", "Sodium Kernelate", "Sodium Palm Kernelate", "Sodium Lauryl Lactylate", "Hyrated Palm Glycerides", "Etyl Palmitate", "Octyl Palmitate", "Palmityl Alcohol",
        "Paraffin", "Fragrance", "Parfum", "Petroleum Jelly", "Almonds"]
        unsustainableIngredients = []
        
        for item in badIngredients:
            if item in ingredients:
                unsustainableIngredients.append(item)

        return unsustainableIngredients

