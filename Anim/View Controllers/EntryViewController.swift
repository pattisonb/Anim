//
//  EntryViewController.swift
//  Anim
//
//  Created by Maria Heredia on 11/17/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self
        datePicker.setDate(Date(), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func didTapSaveButton(_ sender: Any) {
        
        if let text = textField.text, !text.isEmpty {
            let date = datePicker.date

            realm.beginWrite()
            let newItem = Reviews()
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            try! realm.commitWrite()

            //completionHandler?()
        }
        else {
            print("Add something")
        }
        
    }

}
