from flask import Flask
from markupsafe import escape
app = Flask(__name__)

@app.route('/barcode')
def barcodeImageToFoodData():
    # Get's an Image from front end
    # Calls seperate class to process barcode 
    # Return's JSON of food stats e.i. list of unsustainable food, if the food is high sugar, etc.
    return("You just sent a Barcode!")

@app.route('/barcodePath/<path:subpath>')
def show_subpath(subpath):
    # show the subpath after /path/
    return 'This the path for the barcode image: %s' % escape(subpath)

@app.route('/user/<username>')
def show_user_profile(username):
    # show the user profile for that user
    return 'This is %s a user account' % escape(username)


# @app.route('/foodSearch')
# def foodToData():
#     # Get's a food search term and search parameters from front end
#     # Calls seperate class to get the food data
#     # Returns JSON of foods that match the search criteria
#     return

@app.route('/foodSearch/<foodName>')
def search_food(foodName):
    # show the user profile for that user
    return 'Food that you want to search: %s' % escape(foodName)

# # Optional
# @app.route('/createUser') 
# def createUser():
#     # Takes in email, name, password
#     return

# @app.route('/login')
# def userLogin():
#     # Takes in email, password
#     # Returns if it is valid 
#     return

@app.route('/leaveRating')
def userLogin():
    # Takes in email, password
    # Returns if it is valid 
    return 'You just left a rating'

# @app.route('/getRating')
# def userLogin():
#     # Takes in email, password
#     # Returns if it is valid 
#     return

# @app.route('/getUserReviews') 
# def createUser():
#     # Takes in email, name, password
#     return

# @app.route('/leaveReview')
# def userLogin():
#     # Takes in email, password
#     # Returns if it is valid 
#     return
