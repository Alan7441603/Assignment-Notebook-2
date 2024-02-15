//
//  AddAssignment.swift
//  Assignment Notebook 2
//
//  Created by Alan Rivera on 2/14/24.
//

import SwiftUI
struct AddAssignmentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var assignmentList: AssignmentList
    @State private var description = ""
    @State private var dueDate = Date()
    var body: some View {
        NavigationView {
            Form{
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save"){
                if description.count > 0 {
                    let item = AssignmentItem(id: UUID(), description: description, dueDate: dueDate)
                    assignmentList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}
struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(assignmentList: AssignmentList())
    }
}

