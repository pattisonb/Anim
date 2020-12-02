//
//  ProfileViewController.swift
//  Anim
//
//  Created by Brian Pattison on 11/17/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//
//  Purpose: Functionality of Profile View Controller

import UIKit
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var Name: UILabel!
    
    // loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        
        if let user = user {
            
            let firstName = user.email
            self.Name.text = firstName;
          }
    }

}
