//
//  MyList+CoreDataClass.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/6/30.
//
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder) } ?? []
    }
}
