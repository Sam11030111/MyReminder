//
//  MyList+CoreDataProperties.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/6/30.
//
//

import Foundation
import CoreData
import UIKit

extension MyList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }

    @NSManaged public var color: UIColor
    @NSManaged public var name: String
}

extension MyList : Identifiable {

}
