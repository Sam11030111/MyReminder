//
//  PreviewData.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/7/1.
//

import Foundation
import CoreData

class PreviewData {
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
}
