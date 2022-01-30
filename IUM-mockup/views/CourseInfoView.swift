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
    
    @State var isWritingReview = false
    
    @Binding var votedReviews: [Int : Int]
    @Binding var coursesList: [Int : Course]
    @Binding var reviewsList: [Review]
    
    var course: Course
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                Text(course.courseName)
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.top, 7)
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
                
                Divider()
                
                switch(self.selectedIndex) {
                    case 0:
                        InformationView(coursesList: self.$coursesList, subscription: self.$subscription, course: course)
                    case 1:
                        MaterialView()
                    case 2:
                        ReviewsView(isWritingReview: self.isWritingReview, reviewsList: self.$reviewsList, votedReviews: self.$votedReviews, course: course)
                        .sheet(isPresented: self.$isWritingReview) {
                            WriteReview(isWritingReview: self.$isWritingReview, reviewsList: self.$reviewsList, course: self.course)
                        }
                    default:
                        EmptyView()
                }
                
                Spacer()
                
                Divider()
                
                Button(action: {
                    subscription = !subscription
                }){
                    if(subscription) {
                        HStack {
                            Spacer()
                            Text("Annulla iscrizione")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 32/255, green: 32/255, blue: 32/255), lineWidth: 4))
                    } else {
                        HStack {
                            Spacer()
                            Text("Iscriviti al corso")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                    }
                }
                .tint(subscription ? Color(red: 32/255, green: 32/255, blue: 32/255) : Color.white)
                .background(subscription ? Color.white : Color(red: 32/255, green: 32/255, blue: 32/255))
                .cornerRadius(10)
                
            }
            .navigationBarItems(trailing: getAddButtonForView())
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
    
    private func getAddButtonForView() -> Button<Image> {
        switch(self.selectedIndex) {
            case 1:
                return Button(action: {
                    
                }) {
                    Image(systemName: "icloud.and.arrow.up")
                }
            case 2:
                return Button(action: {
                    self.isWritingReview.toggle()
                    print(self.isWritingReview)
                }) {
                    Image(systemName: "square.and.pencil")
                }
            default:
            return Button(action: {
                
            }) {
                Image(systemName: "no-image")
            }
        }
    }
    
}

struct MaterialView: View {
    
    var body: some View {
        ScrollView {
            Button(action: {
                print("not implemented yet")
            }) {
                VStack {
                    
                    HStack(alignment: .center) {
                        Spacer()
                        VStack(alignment: .leading, spacing: 0){
                            
                            Text(":(")
                                .font(.system(size: 20, weight: .black))
                                .foregroundColor(.white)
                            
                        }
                        Spacer()
                    }
                    .padding()
                }
                .frame(height: 170, alignment: .leading)
            }
            .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 32/255, green: 32/255, blue:32/255))
                            .shadow(color: .black, radius: 3))
        
            .padding(.leading)
            .padding(.trailing)
            .padding(.top, 10)
        }
    }
    
}

struct ReviewsView: View {
    
    @State var isWritingReview: Bool
    
    @Binding var reviewsList: [Review]
    @Binding var votedReviews: [Int : Int]
    
    var course: Course
    
    var body: some View {
        
        ScrollView {
            
            Divider()
            
            ForEach(reviewsList.filter { $0.courseID == course.id }.sorted(by: { $0.id > $1.id})) { review in
                
                ReviewRow(review: review, votedReviews: self.$votedReviews)
                
                Divider()
                
            }
            
        }
        
    }
    
}

struct InformationView: View {
    
    @Binding var coursesList: [Int : Course]
    @Binding var subscription: Bool
    
    var course: Course
    
    var body: some View {
        
        return VStack(alignment: .leading) {
            
            ScrollView {
                
                HStack {
                    Text("Anno Accademico:")
                        .font(Font.system(size: 18))
                        .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                        .fontWeight(.heavy)
                    Text(course.accademicYear)
                        .font(Font.system(size: 18))
                        .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.bottom, 5)
                .padding(.top, 5)
                
                HStack {
                    Text("Descrizione:")
                        .font(Font.system(size: 18))
                        .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding(.bottom, 5)
                .padding(.top, 5)
                Text(course.description)
                
            }
            
        }
        .background(Color.white)
        
    }
    
}
