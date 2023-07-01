//
//  MyReminderApp.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/6/30.
//

import SwiftUI

@main
struct MyReminderApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
