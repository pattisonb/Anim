//
//  CameraViewController.swift
//  Anim
//
//  Created by Manov Jain on 11/5/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//
//  Purpose: Functionality of Camera View Controller

import UIKit
import Alamofire

class CameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // variables linked directly to buttons used in this VC
    var imagePickerController : UIImagePickerController!
    
    public var completionHandler: ((Data?) -> Void)?
    
    var JSON: Data?
    
    // loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    //this function allows user to use their phone's camera functionality
    @IBAction func takePhotoButton(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        //calling saveImage function
        saveImage();
    }
    
    
    //saves image to jpegData type and sends it back to product view
    func saveImage(){
        let data = imageView.image?.jpegData(compressionQuality: 0.6)
        completionHandler?(data)
        dismiss(animated: true, completion: nil)
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
    
    
}


