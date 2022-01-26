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
    
    @Binding var votedReviews: [Int : Int]
    @Binding var coursesList: [Int : Course]
    @Binding var reviewsList: [Review]
    
    init(coursesList: Binding<[Int : Course]>, reviewsList: Binding<[Review]>, votedReviews: Binding<[Int : Int]>) {
        
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().barStyle = .default
        
        self._coursesList = coursesList
        self._reviewsList = reviewsList
        self._votedReviews = votedReviews
        
    }
    
    var body: some View {
        return TabView {
                
            MyCoursesView(votedReviews: self.$votedReviews, coursesList: self.$coursesList, reviewsList: self.$reviewsList)
            .tabItem {
                Label("I miei corsi", systemImage: "books.vertical")
            }

            CourseSearchView(votedReviews: self.$votedReviews, coursesList: self.$coursesList, reviewsList: self.$reviewsList)
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
    
    @State static var votedReviews: [Int : Int] = [:]
    @State static var coursesList: [Int : Course] = [:]
    @State static var reviewsList: [Review] = []
    
    static var previews: some View {
        Group {
            MainView(coursesList: $coursesList, reviewsList: self.$reviewsList, votedReviews: self.$votedReviews)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
