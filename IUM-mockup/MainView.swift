//
//  MainView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 12/01/22.
//

import SwiftUI
import Introspect

struct MainView: View {
    
    @State var uiTabarController: UITabBarController?
    
    @Binding var coursesList: [Int : Course]
    
    init(coursesList: Binding<[Int : Course]>) {
        
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().barStyle = .default
        
        self._coursesList = coursesList
        
    }
    
    var body: some View {
        return TabView {
                
            MyCoursesView(coursesList: self.$coursesList)
            .tabItem {
                Label("I miei corsi", systemImage: "books.vertical")
            }

            CourseSearchView(coursesList: self.$coursesList)
            .tabItem {
                Label("Ricerca corsi", systemImage: "magnifyingglass")
            }
            
            Text("Coming s00n")
            .tabItem {
                Label("Materiali salvati", systemImage: "bookmark")
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    @State static var coursesList: [Int : Course] = [:]
    
    static var previews: some View {
        Group {
            MainView(coursesList: $coursesList)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
