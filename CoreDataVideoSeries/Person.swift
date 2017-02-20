//
//  Person.swift
//  CoreDataVideoSeries
//
//  Created by student on 2017-02-15.
//  Copyright © 2017 student. All rights reserved.
//

import Foundation

class Person {
    var firstName:String
    var lastName:String
    var theNSManagedObject:PersonEntity
    
    init(firstName:String, lastName:String, theNSManagedObject:PersonEntity) {
        self.firstName = firstName
        self.lastName = lastName
        self.theNSManagedObject = theNSManagedObject
    }
}
