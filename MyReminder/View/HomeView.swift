//
//  ContentView.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/6/30.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var reminders: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.reminderByStatType(statType: .today))
    private var todayResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.reminderByStatType(statType: .scheduled))
    private var scheduledResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.reminderByStatType(statType: .all))
    private var allResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.reminderByStatType(statType: .completed))
    private var completedResults: FetchedResults<Reminder>
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var isSearching: Bool = false
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValue = ReminderStatsValues()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValue.todayCount, iconColor: .blue)
                        }

                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatsValue.scheduledCount, iconColor: .red)
                        }
                    }
                    
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValue.allCount, iconColor: .gray)
                        }

                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValue.completedCount, iconColor: .black)
                        }
                    }
                    
                    Text("My List")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    MyListView(myLists: myListResults)
                                        
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }
                    .padding()
                }
            }
            .onChange(of: search, perform: { searchTerm in
                isSearching = !searchTerm.isEmpty ? true : false
                reminders.nsPredicate = ReminderService.getRemindersFromSearchTerm(searchTerm).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: reminders)
                    .opacity(isSearching ? 1.0 : 0.0)
            })
            .onAppear {
                reminderStatsValue = reminderStatsBuilder.build(myListResults: myListResults)
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        // save the list
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Reminders")
        }
        .searchable(text: $search)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
