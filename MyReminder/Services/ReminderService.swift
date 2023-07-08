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
    
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        let reminder = reminder
        reminder.isCompleted = editConfig.isCompleted
        reminder.title = editConfig.title
        reminder.notes = editConfig.notes
        reminder.reminderDate = editConfig.hasDate ? editConfig.reminderDate : nil
        reminder.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil
        
        try save()
        return true
    }
    
    static func deleteReminder(reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    static func getRemindersFromSearchTerm(_ searchTerm: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        return request
    }
    
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    static func reminderByStatType(statType: ReminderStatType) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        
        switch statType {
            case .all:
                request.predicate = NSPredicate(format: "isCompleted = false")
            case .today:
                let today = Date()
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
                request.predicate = NSPredicate(format: "(reminderDate >= %@) AND (reminderDate < %@)", today as NSDate, tomorrow! as NSDate)
            case .scheduled:
                request.predicate = NSPredicate(format: "(reminderDate != nil OR reminderTime != nil) AND isCompleted = false")
            case .completed:
                request.predicate = NSPredicate(format: "isCompleted = true")
        }
        
        return request
    }
    
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        return request
    }
}
