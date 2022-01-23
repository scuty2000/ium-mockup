//
//  CourseInfoView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 11/01/22.
//

import SwiftUI
import Introspect

struct CourseInfoView: View {
    
    @State var selectedIndex: Int = 0
    @State var subscription: Bool
    @State var uiTabarController: UITabBarController?
    
    @Binding var coursesList: [Int : Course]
    
    var course: Course
    
    var body: some View {
        ScrollView {
            VStack() {
                Text(course.courseName)
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    .padding(.top, 5)
                HStack(alignment: .center, spacing: 0){
                    Text(course.attendantName)
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
                HStack(alignment: .center, spacing: 0){
                    Text("Valutazione generale:")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .padding(.trailing, 5)
                    HStack(spacing: 0) {
                        ForEach(0..<course.valutation) { _ in
                            Image(systemName: "star.fill")
                                .imageScale(.medium)
                                .foregroundColor(.brown)
                        }
                        ForEach(0..<5 - course.valutation) { _ in
                            Image(systemName: "star")
                                .imageScale(.medium)
                                .foregroundColor(.brown)
                        }
                    }
                }
                Picker("", selection: self.$selectedIndex) {
                    Text("Informazioni").tag(0)
                    Text("Materiali").tag(1)
                    Text("Recensioni").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                switch(self.selectedIndex) {
                    case 0:
                    InformationView(coursesList: self.$coursesList, subscription: self.$subscription, course: course)
                    default:
                        EmptyView()
                }
                
                
            }
            .padding(.trailing)
            .padding(.leading)
            .frame(alignment: .top)
            .navigationBarTitle(course.abbreviatedName ?? course.courseName, displayMode: .inline)
            .introspectTabBarController { (UITabBarController) in
                        UITabBarController.tabBar.isHidden = true
                        uiTabarController = UITabBarController
                    }.onDisappear() {
                        uiTabarController?.tabBar.isHidden = false
                        setSubscription()
                    }
            }
    }
    
    func setSubscription() {
        coursesList[course.id]?.subscribed = subscription
    }
    
}

struct InformationView: View {
    
    @Binding var coursesList: [Int : Course]
    @Binding var subscription: Bool
    
    var course: Course
    
    var body: some View {
        
        return VStack {
            
            HStack {
                Button(action: {
                    subscription = !subscription
                }){
                    if(subscription) {
                        Text("Annulla iscrizione")
                            .padding(15)
                            .overlay(RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.red, lineWidth: 2))
                    } else {
                        Text("Iscriviti al corso")
                            .padding(15)
                    }
                }
                .tint(subscription ? Color.red : Color.white)
                .background(subscription ? Color.white : Color(red: 32/255, green: 32/255, blue: 32/255))
                .cornerRadius(13)
                Spacer()
            }
            .padding(.top, 10)
            
        }
        
    }
    
}
