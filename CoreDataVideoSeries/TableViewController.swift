//
//  TableViewController.swift
//  CoreDataVideoSeries
//
//  Created by student on 2017-02-15.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, PersonUpdatable {

    var thePersonList = [Person]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    func updateAPerson(thePerson:Person, index:Int) {
        self.thePersonList[index] = thePerson
    }
    
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPeopleFromCoreData()
    }
    
    func loadPeopleFromCoreData() {
        let theFetchRequest:NSFetchRequest<PersonEntity> = PersonEntity.fetchRequest()
        
        do {
            for aPersonEntity in try self.managedObjectContext.fetch(theFetchRequest) {
                let aPerson = Person(firstName: aPersonEntity.first_name!, lastName: aPersonEntity.last_name!, theNSManagedObject: aPersonEntity)
                self.thePersonList.append(aPerson)
            }
        } catch {
            print("Error loading data from Core Data - \(error.localizedDescription)")
        }
    }

    @IBAction func doAdd(_ sender: Any) {
        let theAlert = UIAlertController(title: "Add Person", message: "Please enter...", preferredStyle: .alert)
        theAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        theAlert.addTextField(configurationHandler: nil)
        theAlert.addTextField(configurationHandler: nil)
        theAlert.addAction(UIAlertAction(title: "Add", style: .default) { (_) in
            let theFirstName = theAlert.textFields?.first?.text
            let theLastName = theAlert.textFields?.last?.text
            
            let thePersonEntity = PersonEntity(context: self.managedObjectContext)
            thePersonEntity.first_name = theFirstName
            thePersonEntity.last_name = theLastName
            
            self.thePersonList.append(Person(firstName: theFirstName!, lastName: theLastName!, theNSManagedObject: thePersonEntity))
            
            do {
                try self.managedObjectContext.save()
            }
            catch {
                print("Error save to Core Data - \(error.localizedDescription)")
            }

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            nextVC.thePerson = self.thePersonList[indexPath.row]
            nextVC.theIndex = indexPath.row
            nextVC.personUpdatableObject=self
        }
    }

}
