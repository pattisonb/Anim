//
//  SignUpViewController.swift
//  Anim
//
//  Created by Manov Jain on 11/5/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: NSLayoutConstraint!
    
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
//
//         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//
//        tap.cancelsTouchesInView = false
//
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUpElements() {
    
        // Hide the error label
        errorLabel.alpha = 0
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    }
    
}
