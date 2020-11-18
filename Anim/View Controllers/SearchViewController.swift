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
//       var search = searchTextField.text
//        var url = "http://159.89.231.85:5000/foodSearch/"
//
//        var barsearch = url + search!
//
//
//        AF.request(barsearch).response { response in
//            debugPrint(response)
//        }
        
        
        let str = "{ \"image\": [\"img.jpg\"], \"foodName\": [\"Food name\"], \"dietLabels\": [\"Low Carb\"], \"allergyLabels\": [\"Dairy Free\", \"Milk Free\", \"Peanut Free\", \"Tree Nut Free\", \"Soy Free\", \"Fish Free\", \"Shellfish Free\", \"Alcohol Free\"], \"health\": 0, \"Energy\" : [\"1461.59kcal\"], \"Fat\": [\"104.18g\"], \"Carbs\": [\"27.64g\"], \"Sugars\": [\"15.06g\"], \"Protein\": [\"98.16g\"], \"Fiber\": [\"3.59g\"], \"Sodium\": [\"446.2mg\"], \"nutritionalTags\": [\"High Fat\", \"Low Fiber\", \"High Protein\", \"High Cholesterol\"], \"unsustainable\": [\"Palm Oil\"] }"
        let data = Data(str.utf8)

        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // try to read out a string array
                if let imageArr = json["image"] as? [String] {
                    print(imageArr)
                }
                if let foodName = json["foodName"] as? [String] {
                    print(foodName)
                }
                if let dietLabels = json["dietLabels"] as? [String] {
                    print(dietLabels)
                }
                if let allergyLabels = json["allergyLabels"] as? [String] {
                    print(allergyLabels)
                }
                if let health = json["health"] as? [String] {
                    print(health)
                }
                if let energy = json["Energy"] as? [String] {
                    print(energy)
                }
                if let fat = json["Fat"] as? [String] {
                    print(fat)
                }
                if let carbs = json["Carbs"] as? [String] {
                    print(carbs)
                }
                if let sugar = json["Sugars"] as? [String] {
                    print(sugar)
                }
                if let protein = json["Protein"] as? [String] {
                    print(protein)
                }
                if let fiber = json["Fiber"] as? [String] {
                    print(fiber)
                }
                if let sodium = json["Sodium"] as? [String] {
                    print(sodium)
                }
                if let nutrtionalTags = json["nutritionalTags"] as? [String] {
                    print(nutrtionalTags)
                }
                if let unsutainable = json["unsustainable"] as? [String] {
                    print(unsutainable)
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        
        
        
    }
    
}
