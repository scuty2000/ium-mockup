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
    @Binding var subscribedCourses: Array<Course>
    
    var body: some View {
        switch(activeView) {
        case "miei_corsi":
            MyCoursesView(
                activeView: self.$activeView,
                subscribedCourses: self.$subscribedCourses)
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

struct ContainerView_Previews: PreviewProvider {
    
    @State static var showMenu = false
    @State static var activeView = "miei_corsi"
    @State static var subscribedCourses = Array<Course>()
    
    static var previews: some View {
        ContainerView(
            showMenu: $showMenu,
            activeView: $activeView,
            subscribedCourses: $subscribedCourses
        )
    }
}
