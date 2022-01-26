//
//  CourseSearchView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 13/01/22.
//

import SwiftUI

struct CourseSearchView: View {
    
    @Binding var votedReviews: [Int : Int]
    @Binding var coursesList: [Int : Course]
    @Binding var reviewsList: [Review]

    @State private var isShowingDetailView = false
    @State private var subscribedCourse = false
    @State var selectedCourseID = 0
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
            
            ScrollView {
                
                ForEach(searchResults) { course in
                        CourseRow(
                            isShowingDetailView: self.$isShowingDetailView,
                            selectedCourseID: self.$selectedCourseID,
                            subscribedCourse: self.$subscribedCourse,
                            course: course
                        )
                            .tag(course.id)
                }
                .background(
                    NavigationLink(
                        destination: CourseInfoView(subscription: self.subscribedCourse, votedReviews: self.$votedReviews, coursesList: self.$coursesList, reviewsList: self.$reviewsList, course: coursesList[selectedCourseID] ?? emptyCourse),
                        isActive: $isShowingDetailView
                    ) { EmptyView() }
                )
                .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .always))
                
                if(searchResults.isEmpty) {
                    Text("Nessun corso trovato.")
                }
                
            }
            .navigationBarTitle("Ricerca corsi")
            
        }
        
    }
    
    var searchResults: [Course] {
        if searchString.isEmpty {
            return coursesList.values.filter { !$0.subscribed }.sorted(by: {Int($0.accademicYear.split(separator: "/")[0]) ?? 0 > Int($1.accademicYear.split(separator: "/")[0]) ?? 1})
        } else {
            return coursesList.values.filter { $0.courseName.lowercased().contains(searchString.lowercased()) && !$0.subscribed }.sorted(by: {Int($0.accademicYear.split(separator: "/")[0]) ?? 0 > Int($1.accademicYear.split(separator: "/")[0]) ?? 1})
        }
    }
    
}
