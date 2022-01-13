//
//  MainView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 12/01/22.
//

import SwiftUI

struct MainView: View {
    
    @State var modalIsPresented = false
    
    @State var activeView = ""
    @State var selectedCourseID = 0
    @State var navigationBarTitle = ""
    
    @Binding var coursesList: [Int : Course]
    
    init(coursesList: Binding<[Int : Course]>) {
        
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().barStyle = .default
        
        self._coursesList = coursesList
        
    }
    
    var body: some View {
        
        
        return NavigationView {
            GeometryReader { geometry in
                VStack {
                    MyCoursesView(activeView: self.$activeView, coursesList: self.$coursesList, selectedCourseID: self.$selectedCourseID)
                }
            }
            .navigationBarTitle(Text("I Miei Corsi"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.modalIsPresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(Font.title.weight(.bold))
                        .imageScale(.small)
                }
                .foregroundColor(Color(red: 32/255, green: 32/255, blue: 32/255))
                .sheet(isPresented: self.$modalIsPresented){
                    CourseSearchView(coursesList: self.$coursesList)
                })
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
