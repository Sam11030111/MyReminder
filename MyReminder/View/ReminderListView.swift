//
//  ReminderListView.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/7/2.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    
    private func reminderCheckedChange(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    var body: some View {
        VStack {
            List(reminders) { reminder in
                ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                    switch event {
                    case .onSelect(let reminder):
                        selectedReminder = reminder
                    case .onCheckedChange(let reminder, let isCompleted):
                        reminderCheckedChange(reminder: reminder, isCompleted: isCompleted)
                    case .onInfo:
                        showReminderDetail = true
                    }
                }
            }
        }
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}

/*
struct ReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView()
    }
}
*/
