//
//  ProductViewController.swift
//  Anim
//
//  Created by Manov Jain on 11/19/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//
//  Purpose: Functionality of Product View Controller

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
    var recievedSearch: String?
    var data: Data?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
        func makeRequest(image: Data) {
              let endpointUrl: String = "http://159.89.231.85:5000/barcode"

              // Use Alamofire to make a POST request
              AF.upload(
                  multipartFormData: { formData in
                      formData.append(image, withName: "image", fileName: "someName.jpeg", mimeType: "image/jpeg")
                  },
                  to: endpointUrl
              )
              .response { response in
                // Do something with the response
                // Or - create a struct called ResponseDTO, also conforming to Codable
                // And use `responseDecodable`
              }
                print("sent")
            }
    
    //Using the scan button
    //Takes user from current storyboard view controller (productView) to scan view controller
    @IBAction func didTapScan(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CameraVC") as! CameraViewController
        vc.modalPresentationStyle = .fullScreen
        vc.completionHandler = {text in
            self.data = text
            self.makeRequest(image: self.data!)
            self.getInfoFromScan()
            //taking data from scan view controller
        }
        present(vc,animated: true)

    }
    
    //Using the search button
    //Takes user from current storyboard view controller (productView) to search view controller
    @IBAction func didTapSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SearchVC") as! SearchViewController
        vc.modalPresentationStyle = .fullScreen
        vc.completionHandler = {text in
            self.recievedSearch = text
            self.getInfoFromSearch(inputString: self.recievedSearch!)
            //taking data from search view controller
       }
                present(vc,animated: true)
    }
    

    
    func getInfoFromSearch(inputString: String){
        //URL to recieve info with a search term
        let url = "http://159.89.231.85:5000/foodSearch"
        //adding search term to the URL
        let firstUrl = url + "/" + inputString
        
        AF.request(firstUrl).response { response in
                   debugPrint(response)
        }
        
        //Getting Food Image from search
        var barsearch = url + "Image"
        AF.request(barsearch)
               .responseString { response in
                   print("response: \(response)")
                   switch response.result {
                   case .success(let value):
                       print("value**: \(value)")
                    //getting image from URL
                    let fileUrl = URL(string: value)!
                    DispatchQueue.global().async { [weak self] in
                        if let data = try? Data(contentsOf: fileUrl) {
                                   if let image = UIImage(data: data) {
                                       DispatchQueue.main.async {
                                        //displaying image
                                        self?.productImage.image = image
                                       }
                                   }
                               }
                           }
                   case .failure(let error):
                       print(error)
                   }
               }
        
        //Getting Food Name from search
        barsearch = url + "Name"
        AF.request(barsearch)
               .responseString { response in
                   print("response: \(response)")
                   switch response.result {
                   case .success(let value):
                       print("value**: \(value)")
                    //setting label to given product name
                    self.productNameLabel.text = value
                  
                   case .failure(let error):
                       print(error)
                   }
               }
        
        //Getting Food Diet Labels from search
        barsearch = url + "DietLabels"
        AF.request(barsearch)
               .responseString { response in
                   print("response: \(response)")
                   switch response.result {
                   case .success(let value):
                       print("value**: \(value)")
                    //setting label to given diet labels
                    self.dietaryRestrictions.text = value
                  
                   case .failure(let error):
                       print(error)
                   }
               }
        
        //Getting Food Allergy Labels from search
        barsearch = url + "AllergyLabels"
        AF.request(barsearch)
               .responseString { response in
                   print("response: \(response)")
                   switch response.result {
                   case .success(let value):
                       print("value**: \(value)")
                    //setting label to given allergens
                    self.allergens.text = value
                  
                   case .failure(let error):
                       print(error)
                   }
               }
        
        //Getting HealthScore from search
        barsearch = url + "Health"
        AF.request(barsearch)
               .responseString { response in
                   print("response: \(response)")
                   switch response.result {
                   case .success(let value):
                       print("value**: \(value)")
                    //setting label to given healthScore
                    self.healthScoreLabel.text = "Health Score: " + value + "/10"
                  
                   case .failure(let error):
                       print(error)
                   }
               }
        
        //Getting NutritionalTags from search
        barsearch = url + "NutritionalTags"
        AF.request(barsearch)
               .responseString { response in
                   print("response: \(response)")
                   switch response.result {
                   case .success(let value):
                       print("value**: \(value)")
                    //setting label to given NutrtionalTags
                    self.healthFactors.text = value
                  
                   case .failure(let error):
                       print(error)
                   }
               }
        
        //Getting sustainableScore from search
        barsearch = url + "Unsustainable"
        AF.request(barsearch)
               .responseString { response in
                   print("response: \(response)")
                   switch response.result {
                   case .success(let value):
                       print("value**: \(value)")
                    //setting label to given sustainabilityScore
                    if(value == ""){
                        self.susLabel.text = "Sustainable"
                    }
                    else{
                        self.susLabel.text = "Unsustainable"
                        self.susFactors.text = value
                    }
                  
                   case .failure(let error):
                       print(error)
                   }
               }
    }
    
        func getInfoFromScan(){
            //URL for getting info with a scan
            let url = "http://159.89.231.85:5000/foodSearch"
            
            
            //Getting Food Image from search
            var barsearch = url + "Image"
            AF.request(barsearch)
                   .responseString { response in
                       print("response: \(response)")
                       switch response.result {
                       case .success(let value):
                           print("value**: \(value)")
                        //getting image from URL
                        let fileUrl = URL(string: value)!
                        DispatchQueue.global().async { [weak self] in
                            if let data = try? Data(contentsOf: fileUrl) {
                                       if let image = UIImage(data: data) {
                                           DispatchQueue.main.async {
                                            //displaying image
                                            self?.productImage.image = image
                                           }
                                       }
                                   }
                               }
                       case .failure(let error):
                           print(error)
                       }
                   }
            
            //Getting Food Name from search
            barsearch = url + "Name"
            AF.request(barsearch)
                   .responseString { response in
                       print("response: \(response)")
                       switch response.result {
                       case .success(let value):
                           print("value**: \(value)")
                        //setting label to given product name
                        self.productNameLabel.text = value
                      
                       case .failure(let error):
                           print(error)
                       }
                   }
            
            //Getting Food Diet Labels from search
            barsearch = url + "DietLabels"
            AF.request(barsearch)
                   .responseString { response in
                       print("response: \(response)")
                       switch response.result {
                       case .success(let value):
                           print("value**: \(value)")
                        //setting label to given diet labels
                        self.dietaryRestrictions.text = value
                      
                       case .failure(let error):
                           print(error)
                       }
                   }
            
            //Getting Food Allergy Labels from search
            barsearch = url + "AllergyLabels"
            AF.request(barsearch)
                   .responseString { response in
                       print("response: \(response)")
                       switch response.result {
                       case .success(let value):
                           print("value**: \(value)")
                        //setting label to given allergens
                        self.allergens.text = value
                      
                       case .failure(let error):
                           print(error)
                       }
                   }
            
            //Getting HealthScore from search
            barsearch = url + "Health"
            AF.request(barsearch)
                   .responseString { response in
                       print("response: \(response)")
                       switch response.result {
                       case .success(let value):
                           print("value**: \(value)")
                        //setting label to given healthScore
                        self.healthScoreLabel.text = "Health Score: " + value + "/10"
                      
                       case .failure(let error):
                           print(error)
                       }
                   }
            
            //Getting NutritionalTags from search
            barsearch = url + "NutritionalTags"
            AF.request(barsearch)
                   .responseString { response in
                       print("response: \(response)")
                       switch response.result {
                       case .success(let value):
                           print("value**: \(value)")
                        //setting label to given NutrtionalTags
                        self.healthFactors.text = value
                      
                       case .failure(let error):
                           print(error)
                       }
                   }
            
            //Getting sustainableScore from search
            barsearch = url + "Unsustainable"
            AF.request(barsearch)
                   .responseString { response in
                       print("response: \(response)")
                       switch response.result {
                       case .success(let value):
                           print("value**: \(value)")
                        //setting label to given sustainabilityScore
                        if(value == ""){
                            self.susLabel.text = "Sustainable"
                        }
                        else{
                            self.susLabel.text = "Unsustainable"
                            self.susFactors.text = value
                        }
                      
                       case .failure(let error):
                           print(error)
                       }
                   }
            
        }

}

