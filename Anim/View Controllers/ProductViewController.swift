//
//  ProductViewController.swift
//  Anim
//
//  Created by Manov Jain on 11/19/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import Alamofire
import UIKit

class ProductViewController: UIViewController {
    
    //BigLabels
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var healthScoreLabel: UILabel!
    @IBOutlet weak var susLabel: UILabel!
    @IBOutlet weak var allergenLabel: UILabel!
    @IBOutlet weak var dietaryLabel: UILabel!
    
    //contentLabels
    @IBOutlet weak var healthFactors: UILabel!
    @IBOutlet weak var susFactors: UILabel!
    @IBOutlet weak var allergens: UILabel!
    @IBOutlet weak var dietaryRestrictions: UILabel!
    
    //image
    @IBOutlet weak var productImage: UIImageView!
    
    //buttons
    @IBOutlet weak var scan: UIButton!
    @IBOutlet weak var search: UIButton!
    
    //variables
    var recievedjson: String?
    var data: Data?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
     
//    @IBAction func didTapScan(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(identifier: "CameraVC") as! CameraViewController
//        vc.modalPresentationStyle = .fullScreen
//        vc.completionHandler = {text in
//            print(text)
//            self.recievedjson = text!
//            self.createInfo(inputString: self.recievedjson!)
//        }
//        present(vc,animated: true)
//
//    }
    
    
    @IBAction func didTapSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SearchVC") as! SearchViewController
        vc.modalPresentationStyle = .fullScreen
        vc.completionHandler = {text in
            
            var url = "http://159.89.231.85:5000/foodSearch/"
            var barsearch = url + text!
            
//            AF.request(barsearch).responseString { response in
//                debugPrint(response)
                
            AF.request(barsearch)
                   .responseString { response in
                       print("response: \(response)")
                       switch response.result {
                       case .success(let value):
                        self.recievedjson = value
                           print("value**: \(value)")
                        self.createInfo(inputString: self.recievedjson!)
                           print(type(of: value))
                        
                        
                       case .failure(let error):
                           print(error)
                        
                        
                       }
                   }
            
//            print("SUCCESS")
//            print(self.recievedjson)
//
//            self.createInfo(inputString: self.recievedjson!)
//
                
        }
        
        
        
        
            
        
        present(vc,animated: true)
    }
    
    func createInfo (inputString: String){
        self.data = Data(inputString.utf8)
        
        print("test")
        print(inputString)
        print(data)
        
        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                // try to read out a string array
                if let imageArr = json["image"] as? [String] {
                    let fileUrl = URL(string: imageArr[0])!
                    
                    print("Image")
                    
                    DispatchQueue.global().async { [weak self] in
                        if let data = try? Data(contentsOf: fileUrl) {
                                   if let image = UIImage(data: data) {
                                       DispatchQueue.main.async {
                                        self?.productImage.image = image
                                       }
                                   }
                               }
                           }
                    
                    
                    print(imageArr)
                }
                if let foodName = json["foodName"] as? [String] {
                    print(foodName)
                    productNameLabel.text = foodName[0]
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
//                if let energy = json["Energy"] as? [String] {
//                    print(energy)
//                }
//                if let fat = json["Fat"] as? [String] {
//                    print(fat)
//                }
//                if let carbs = json["Carbs"] as? [String] {
//                    print(carbs)
//                }
//                if let sugar = json["Sugars"] as? [String] {
//                    print(sugar)
//                }
//                if let protein = json["Protein"] as? [String] {
//                    print(protein)
//                }
//                if let fiber = json["Fiber"] as? [String] {
//                    print(fiber)
//                }
//                if let sodium = json["Sodium"] as? [String] {
//                    print(sodium)
//                }
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
