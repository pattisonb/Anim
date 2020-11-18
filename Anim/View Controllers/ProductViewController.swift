//
//  ProductViewController.swift
//  Anim
//
//  Created by Maria Heredia on 11/18/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var votes: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func StepperVotes(_ sender: UIStepper) {
        votes.text = String(sender.value)
    }

}
