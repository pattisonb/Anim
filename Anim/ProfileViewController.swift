//
//  ProfileViewController.swift
//  Anim
//
//  Created by maria on 11/12/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController {
    

    
    @IBOutlet weak var img: UIImageView!
    var imagePicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onClickPickImage(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self;
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true;
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        img.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
}
