//
//  ContentView.swift
//  Assignment Notebook 2
//
//  Created by Alan Rivera on 2/14/24.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.items) { item in
                    VStack(alignment: .leading) {
                        Text(item.course)
                            .font(.headline)
                        HStack {
                            Text(item.dueDate, style: .date)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                        .background(Color.red)
                        .border(Color.black, width: 2)
                        .cornerRadius(7)
                        Text(item.description)
                            .padding(.leading, 8)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 4)
                            .background(Color.red)
                            .border(Color.black, width: 2)
                            .cornerRadius(7)
                    }
                }
                .onMove { indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                }
                .onDelete { indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                }
            }
            .sheet(isPresented: $showingAddAssignmentView) {
                AddAssignmentView(assignmentList: assignmentList)
            }
            .navigationBarTitle("Assignments", displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing: Button(action: { showingAddAssignmentView = true }) {
                Image(systemName: "plus")
            })
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
