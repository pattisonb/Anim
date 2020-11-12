//
//  RateViewController.swift
//  Anim
//
//  Created by maria on 11/12/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
              
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
