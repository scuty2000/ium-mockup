//
//  MyCoursesView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 09/01/22.
//

import SwiftUI

struct MyCoursesView: View {
    
    @Binding var coursesList: [Int : Course]
    
    @State private var isShowingDetailView = false
    @State private var subscribedCourse = false
    @State var selectedCourseID = -1
    @State var searchString = ""
    
    var emptyCourse = Course(
        id: -1,
        courseName: "",
        attendantName: "",
        accademicYear: "",
        description: "",
        valutation: 0,
        subscribed: false
    )
    
    var body: some View {
        NavigationView {
            if (coursesList.values.filter{ $0.subscribed }.isEmpty) {
                VStack {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.slash")
                        .font(.system(size: 100, weight: .regular))
                        .foregroundColor(.gray)
                    Text("Non sei iscritto ad alcun corso!\nEsplora il catalogo per iniziare.")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
                .navigationTitle("I miei corsi")
            } else {
                ScrollView {
                    ForEach(searchResults) { course in
                        CourseRow(
                            isShowingDetailView: self.$isShowingDetailView,
                            selectedCourseID: self.$selectedCourseID,
                            subscribedCourse: self.$subscribedCourse,
                            course: course
                        ).tag(course.id)
                    }
                    .background(
                        NavigationLink(
                            destination: CourseInfoView(subscription: self.subscribedCourse, coursesList: self.$coursesList, course: coursesList[selectedCourseID] ?? emptyCourse),
                            isActive: $isShowingDetailView
                        ) { EmptyView() }
                    )
                    .searchable(text: $searchString)
                }
                .navigationTitle("I miei corsi")
            }
        }
    }
    
    var searchResults: [Course] {
        if searchString.isEmpty {
            return coursesList.values.filter { $0.subscribed }.sorted(by: {$0.id < $1.id})
        } else {
            return coursesList.values.filter { $0.courseName.lowercased().contains(searchString.lowercased()) && $0.subscribed }.sorted(by: {$0.id < $1.id})
        }
    }
    
}
