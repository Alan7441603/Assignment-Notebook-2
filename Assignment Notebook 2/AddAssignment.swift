//
//  AddAssignment.swift
//  Assignment Notebook 2
//
//  Created by Alan Rivera on 2/14/24.
//

import SwiftUI
struct AddAssignmentView: View {
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["Math", "Elective", "Language", "English", "Health", "Science", "History"]
    @ObservedObject var assignmentList: AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    var body: some View {
        NavigationView {
            Form{
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) {course in
                        Text(course)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save")
                {
                if course.count > 0 && description.count > 0 {
                    let item = AssignmentItem(id: UUID(), course: course, description: description, dueDate: dueDate)
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

