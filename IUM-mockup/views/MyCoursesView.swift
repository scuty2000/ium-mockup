//
//  MyCoursesView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 09/01/22.
//

import SwiftUI

struct MyCoursesView: View {
    
    @Binding var activeView: String
    @Binding var subscribedCourses: Array<Course>
    
    var body: some View {
        if (subscribedCourses.isEmpty) {
            VStack {
                Text("Non sei iscritto ad alcun corso!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                Button(action: {
                    self.activeView = "lista_corsi"
                }) {
                    HStack {
                        Text("Ricerca corsi")
                        .font(.title2)
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                    }
                }
                .buttonStyle(.bordered)
                .cornerRadius(8)
                .tint(Color(red: 32/255, green: 32/255, blue: 32/255))
            }
        }
    }
}

struct MyCoursesView_Previews: PreviewProvider {
    
    @State static var subscribedCourses = Array<Course>()
    @State static var activeView = "miei_corsi"
    
    static var previews: some View {
        MyCoursesView(
            activeView: $activeView,
            subscribedCourses: $subscribedCourses
        )
    }
}
