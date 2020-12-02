//
//  EntryViewController.swift
//  Anim
//
//  Created by Maria Heredia on 11/17/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//
//  Purpose: Functionality of Entry View Controller

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    // variables linked directly to buttons used in this VC
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    // loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self
        datePicker.setDate(Date(), animated: true)
    }
    
    // functionality of user typing in a new review in a text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // functionality of user saving a new review
    @IBAction func didTapSaveButton(_ sender: Any) {
        
        if let text = textField.text, !text.isEmpty {
            let date = datePicker.date

            realm.beginWrite()
            let newItem = Reviews()
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            try! realm.commitWrite()

        }
        
        // if user does not add a new review, it checks
        else {
            print("Add something")
        }
        
    }

}
