//
//  ViewController.swift
//  Anim
//
//  Created by Manov Jain on 9/1/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//
import UIKit
import Alamofire

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UIStackView!
    
    @IBOutlet weak var passwordTextField: DesignableView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//
//        tap.cancelsTouchesInView = false
//
//        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUpElements() {
    
        // Hide the error label
        errorLabel.alpha = 0
    }
    
    @IBAction func loginTapped(_ sender: Any) {
    }
    

}
