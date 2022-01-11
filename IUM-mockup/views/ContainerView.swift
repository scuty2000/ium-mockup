//
//  ContainerView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 09/01/22.
//

import SwiftUI

struct ContainerView: View {
    
    @Binding var showMenu: Bool
    @Binding var activeView: String
    @Binding var coursesList: [Int : Course]
    @Binding var selectedCourseID: Int
    @Binding var navigationBarTitle: String
    
    var body: some View {
        switch(activeView) {
        case "miei_corsi":
            MyCoursesView(
                activeView: self.$activeView,
                coursesList: self.$coursesList,
                selectedCourseID: self.$selectedCourseID
            )
        case "course_info":
            CourseInfoView(
                coursesList: self.$coursesList,
                selectedCourseID: self.$selectedCourseID,
                navigationBarTitle: self.$navigationBarTitle
            )
        default:
            DefaultView()
        }
    }
    
}

struct DefaultView: View {
    
    var body: some View {
        
        Text("Default container view")
    
    }
    
}
