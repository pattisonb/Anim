//
//  SearchViewController.swift
//  Anim
//
//  Created by Manov Jain on 11/14/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    

    
    let testURL = "hello.com"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

       tap.cancelsTouchesInView = false

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    @IBAction func searchButton(_ sender: Any) {
       var search = searchTextField.text
        var url = "http://159.89.231.85:5000/foodSearch/"
        
        var barsearch = url + search!
        
        
        AF.request(barsearch).response { response in
            debugPrint(response)
        }
        
        
        let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
        let data = Data(str.utf8)

        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // try to read out a string array
                if let names = json["names"] as? [String] {
                    print(names)
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        
        
        
    }
    
}
