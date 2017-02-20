//
//  ViewController.swift
//  CoreDataVideoSeries
//
//  Created by Chris Chadillon on 2017-02-19.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstNameText: UITextField!
    @IBOutlet var lastNameText: UITextField!
    
    var personUpdatableObject:PersonUpdatable!
    var thePerson:Person!
    var theIndex:Int!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.firstNameText.text = self.thePerson.firstName
        self.lastNameText.text = self.thePerson.lastName
    }

    @IBAction func doAdd(_ sender: UIButton) {
        self.thePerson.firstName = self.firstNameText.text!
        self.thePerson.lastName = self.lastNameText.text!
        self.personUpdatableObject.updateAPerson(thePerson: self.thePerson, index: self.theIndex)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
