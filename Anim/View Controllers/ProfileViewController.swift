//
//  ProfileViewController.swift
//  Anim
//
//  Created by Brian Pattison on 11/17/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class ProfileViewController: UIViewController {

    @IBOutlet weak var Name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        
        if let user = user {
            
            let firstName = user.email
            self.Name.text = firstName;
          }
    }

}
