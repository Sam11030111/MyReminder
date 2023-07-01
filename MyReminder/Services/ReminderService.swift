//
//  ReminderService.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/7/1.
//

import Foundation
import CoreData
import UIKit

class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func saveMyList(_ name: String, _ color: UIColor ) throws {
        let mylist = MyList(context: viewContext)
        mylist.name = name
        mylist.color = color
        try save()
    }
}
