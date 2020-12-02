//
//  ViewController.swift
//  Anim
//
//  Created by Maria Heredia on 11/14/20.
//  Copyright © 2020 Maria Heredia. All rights reserved.
//
//  Purpose: Functionality of Login View Controller

import UIKit
import Alamofire
import FirebaseAuth

class ViewController: UIViewController {

    // variables linked directly to buttons used in this VC
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        //allows the user to tap anywhere on the screen to make the keyboard go away
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
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
    
    // login button: this button is linked directly to the login button in the VC
    // once the user is done login up, the account is authenticated through Googgle's
    // firebase authenticatiion & the user can login with their pre-existing account
    @IBAction func loginTapped(_ sender: Any) {
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {

            }
        }
        
    }
    
}
