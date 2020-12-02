//
//  RateViewController.swift
//  Anim
//
//  Created by Maria Heredia on 11/17/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//
//  Purpose: Functionality of Review View Controller

import UIKit
import RealmSwift

// class variables for making a new review
class Reviews: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

// review view contro/Users/maria/Desktop/Anim/Anim/View Controllers/SignUpViewController.swiftller functionality
class RateViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    // variables linked directly to buttons used in this VC
    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var votes: UILabel!
    
    private let realm = try! Realm()
    private var data = [Reviews]()
 
    // loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()

        data = realm.objects(Reviews.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    // creating a table for the past review
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    // design of table for the past review
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    // design of table for the past review
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // functionality of upvoting a product
    @IBAction func upVote(_ sender: UIStepper) {
        votes.text = Int(sender.value).description
    }
    
    // functionality that links directly to add review button
    @IBAction func didTapAddButton(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else {
            return
        }
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    // once the add a new review button is tapped, this will lead the user
    // to the actual view controller where they can add a new review
    func refresh() {
        data = realm.objects(Reviews.self).map({ $0 })
        table.reloadData()
    }

}
