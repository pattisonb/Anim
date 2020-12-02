//
//  SearchViewController.swift
//  Anim
//
//  Created by Manov Jain on 11/14/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//
//  Purpose: Functionality of Search View Controller

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    // variables linked directly to buttons used in this VC
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    public var completionHandler: ((String?) -> Void)?
    
    var JSON: Data?

    // loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()

        //allows the user to tap anywhere on the screen to make the keyboard go away
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

       tap.cancelsTouchesInView = false

    }
    
    // once the user is done typing, the keyboard goes away
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    @IBAction func searchButton(_ sender: Any) {

        //a dummy image string used for testing
        
        let str = "{ \"image\": [\"https://upload.wikimedia.org/wikipedia/commons/0/07/Honeycrisp-Apple.jpg\"], \"foodName\": [\"Food name\"], \"dietLabels\": [\"Low Carb\"], \"allergyLabels\": [\"Dairy Free\", \"Milk Free\", \"Peanut Free\", \"Tree Nut Free\", \"Soy Free\", \"Fish Free\", \"Shellfish Free\", \"Alcohol Free\"], \"health\": 0, \"Energy\" : [\"1461.59kcal\"], \"Fat\": [\"104.18g\"], \"Carbs\": [\"27.64g\"], \"Sugars\": [\"15.06g\"], \"Protein\": [\"98.16g\"], \"Fiber\": [\"3.59g\"], \"Sodium\": [\"446.2mg\"], \"nutritionalTags\": [\"High Fat\", \"Low Fiber\", \"High Protein\", \"High Cholesterol\"], \"unsustainable\": [\"Palm Oil\"] }"
        let data = Data(str.utf8)
        
        
        //sending data back to productView
        completionHandler?(searchTextField.text)
        dismiss(animated: true, completion: nil)
        
        
    }
    
}
