//
//  RateViewController.swift
//  Anim
//
//  Created by Maria Heredia on 11/17/20.
//  Copyright © 2020 ManovJain. All rights reserved.
//

import UIKit
import RealmSwift

class Reviews: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

class RateViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var votes: UILabel!
    
    private let realm = try! Realm()
    private var data = [Reviews]()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        data = realm.objects(Reviews.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func upVote(_ sender: UIStepper) {
        votes.text = Int(sender.value).description
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else {
            return
        }
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh() {
        data = realm.objects(Reviews.self).map({ $0 })
        table.reloadData()
    }

}
