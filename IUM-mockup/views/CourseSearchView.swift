//
//  CourseSearchView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 13/01/22.
//

import SwiftUI

struct CourseSearchView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var searchString = ""
    
    @Binding var coursesList: [Int : Course]
    
    var body: some View {
        
        VStack {
            
            SearchBar(text: $searchString)
                
            ForEach(searchString == "" ? coursesList.values.filter { !$0.subscribed } : coursesList.values.filter { $0.courseName.contains(searchString) && !$0.subscribed }) { course in
                Text(course.courseName)
            }
            .navigationBarTitle("Courses")
            
        }
        
    }
}

struct SearchBar: View {
    @Binding var text: String
 
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            HStack {
            Image(systemName: "magnifyingglass")
                    .padding(.leading, 7)
            
            TextField("Search ...", text: $text)
                .padding(.top,7)
                .padding(.bottom,7)
                .padding(.trailing, 25)
                .onTapGesture {
                    self.isEditing = true
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(25)
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
