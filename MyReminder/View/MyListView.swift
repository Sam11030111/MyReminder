//
//  MyListView.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/7/1.
//

import SwiftUI

struct MyListView: View {
    
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No Reminders Find")
            } else {
                ForEach(myLists) { myList in
                    NavigationLink(value: myList) {
                        VStack {
                            MyListCellView(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                                .font(.title3)
                                
                            Divider()
                        }
                        .foregroundColor(.black)
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self) { myList in
                    MyListDetailView(myList: myList)
                        .navigationTitle(myList.name)
                }
            }
        }
    }
}

/*
struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
*/
