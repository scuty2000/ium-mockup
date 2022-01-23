//
//  CourseSearchView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 13/01/22.
//

import SwiftUI

struct CourseSearchView: View {
    
    
    @Binding var coursesList: [Int : Course]

    @State private var isShowingDetailView = false
    @State private var subscribedCourse = false
    @State var selectedCourseID = 0
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
                        destination: CourseInfoView(subscription: self.subscribedCourse, coursesList: self.$coursesList, course: coursesList[selectedCourseID] ?? emptyCourse),
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
            return coursesList.values.filter { !$0.subscribed }.sorted(by: {$0.id < $1.id})
        } else {
            return coursesList.values.filter { $0.courseName.lowercased().contains(searchString.lowercased()) && !$0.subscribed }.sorted(by: {$0.id < $1.id})
        }
    }
    
}
