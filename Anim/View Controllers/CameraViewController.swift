//
//  CameraViewController.swift
//  Anim
//
//  Created by Manov Jain on 11/5/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit
import Alamofire

class CameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var imagePickerController : UIImagePickerController!
    
    public var completionHandler: ((Data?) -> Void)?
    
    var JSON: Data?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func takePhotoButton(_ sender: Any) {
        
        imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        
        present(imagePickerController, animated: true, completion: nil)
        
        
        // ????
        //saveImage();
        
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    imagePickerController.dismiss(animated: true, completion: nil)
        
    imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    
    //????
    saveImage();
    }
    
    
    
    func saveImage(){
        
//        let data = imageView.image?.pngData()
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        makeRequest(image: data!)

        AF.request("http://159.89.231.85:5000/barcode").response { response in
            debugPrint(response)
        
            
            let JSON = response.result.self
            print(JSON)
        }
            //sending data back to productView
            completionHandler?(JSON)
            dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func savePhotoButton(_ sender: Any) {
        print("button pressed")
        saveImage()
        print("saveimage")
        
    }
    
    
    @IBAction func galleryButton(_ sender: Any) {
        performSegue(withIdentifier: "gallerySegue", sender: self)
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


