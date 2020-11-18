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
            
            let firstName = user.uid
            print(firstName)
            self.Name.text = firstName;
          }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
