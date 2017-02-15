//
//  TableViewController.swift
//  CoreDataVideoSeries
//
//  Created by student on 2017-02-15.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var thePersonList = [Person]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doAdd(_ sender: Any) {
        let theAlert = UIAlertController(title: "Add Person", message: "Please enter...", preferredStyle: .alert)
        theAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        theAlert.addTextField(configurationHandler: nil)
        theAlert.addTextField(configurationHandler: nil)
        theAlert.addAction(UIAlertAction(title: "Add", style: .default) { (_) in
            let theFirstName = theAlert.textFields?.first?.text
            let theLastName = theAlert.textFields?.last?.text
            
            self.thePersonList.append(Person(firstName: theFirstName!, lastName: theLastName!))

            }
        )
        
        present(theAlert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thePersonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.thePersonList[indexPath.row].lastName
        cell.detailTextLabel?.text = self.thePersonList[indexPath.row].firstName
        
        return cell
    }

}
