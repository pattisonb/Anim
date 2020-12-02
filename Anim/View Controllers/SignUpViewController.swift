//
//  SignUpViewController.swift
//  Anim
//
//  Created by Maria Heredia on 11/14/20.
//  Copyright © 2020 Maria Heredia. All rights reserved.
//
//  Purpose: Functionality of Sign UP View Controller

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    // variables linked directly to buttons used in this VC
    @IBOutlet weak var firstNameTextField: UITextField!

    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var errorLabel: UILabel!
    
    // loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

        //allows the user to tap anywhere on the screen to make the keyboard go away
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
    }

    // once the user is done typing, the keyboard goes away
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // hiding the error label if the user types the correct input
    func setUpElements() {
    
        // Hide the error label
        errorLabel.alpha = 0
    }
    
    // Check the fields and validate that the data is correct. If everything is
    // correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    // signup button: this button is linked directly to the signup button in the VC
    // once the user is done sighning up, the account is created through Googgle's
    // firebase authenticatiion & the user can login with their new account
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
        
            }
            
        }
    }
    
    // if the user inputs incorrect text for the signup fields, an error is shown
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    // after the user taps the login button, it will take them to the home VC
    func transitionToHome() {
            
        let TabViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.TabViewController) as? TabViewController
            
            view.window?.rootViewController = TabViewController
            view.window?.makeKeyAndVisible()
        
    }
}
