//
//  MyCoursesView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 09/01/22.
//

import SwiftUI

struct MyCoursesView: View {
    
    @Binding var votedReviews: [Int : Int]
    @Binding var coursesList: [Int : Course]
    @Binding var reviewsList: [Review]
    
    @State private var isShowingDetailView = false
    @State private var subscribedCourse = false
    @State var selectedCourseID = -1
    @State var searchString = ""
    
    var emptyCourse = Course(
        id: -1,
        courseName: "",
        attendantName: "",
        accademicYear: "",
        cfu: "",
        relativeYear: "",
        semester: "",
        channel: "",
        description: "",
        valutation: 0,
        subscribed: false
    )
    
    var body: some View {
        NavigationView {
            if (coursesList.values.filter{ $0.subscribed }.isEmpty) {
                HStack {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.slash")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(.gray)
                    Text("Non sei iscritto ad alcun corso!\nEsplora il catalogo per iniziare.")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                        .offset(y: CGFloat(-5))
                }
                .navigationTitle("I miei corsi")
                .navigationBarTitleDisplayMode(.inline)
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
                            destination: CourseInfoView(subscription: self.subscribedCourse, votedReviews: self.$votedReviews, coursesList: self.$coursesList, reviewsList: self.$reviewsList, course: coursesList[selectedCourseID] ?? emptyCourse),
                            isActive: $isShowingDetailView
                        ) { EmptyView() }
                    )
                    .searchable(text: $searchString)
                }
                .navigationTitle("I miei corsi")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
    
    var searchResults: [Course] {
        if searchString.isEmpty {
            return coursesList.values.filter { $0.subscribed }.sorted(by: {Int($0.accademicYear.split(separator: "/")[0]) ?? 0 > Int($1.accademicYear.split(separator: "/")[0]) ?? 1})
        } else {
            return coursesList.values.filter { ($0.courseName.lowercased().contains(searchString.lowercased()) || $0.attendantName.lowercased().contains(searchString.lowercased())) && $0.subscribed }.sorted(by: {Int($0.accademicYear.split(separator: "/")[0]) ?? 0 > Int($1.accademicYear.split(separator: "/")[0]) ?? 1})
        }
    }
    
}
