//
//  MyCoursesView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 09/01/22.
//

import SwiftUI

struct MyCoursesView: View {
    
    @Binding var activeView: String
    @Binding var coursesList: [Course]
    @Binding var selectedCourseID: Int
    
    var body: some View {
        if (coursesList.filter{ $0.subscribed }.isEmpty) {
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
        } else {
            
            ScrollView {
                ForEach(self.coursesList.filter{ $0.subscribed }) { course in
                    CourseRow(course: course)
                        .background(RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(red: 32/255, green: 32/255, blue:32/255))
                                        .shadow(color: .black, radius: 3))
                    
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top, 10)
                }
            }
            
        }
    }
    
}

struct CourseRow: View {

    var course: Course

    var body: some View {
        Button(action: {
            print(course.courseName)
        }) {
            VStack{
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text(course.courseName)
                                .font(.system(size: 23))
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        Text(course.attendantName)
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                        HStack(spacing: 0) {
                            Text("Anno Accademico:")
                                .font(.system(size: 17))
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                                .padding(.trailing, 5)
                            Text(course.accademicYear)
                                .font(.system(size: 17))
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                        }
                        .padding(.top, 10)
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

                    }
                    
                    Image(systemName: "arrow.up.right.square.fill")
                        .foregroundColor(.white)
                        .imageScale(.large)
                        .offset(y: 45)
                    
                }
                .padding()
            }
            .frame(height: 140, alignment: .leading)
        }
    }
}

struct MyCoursesView_Previews: PreviewProvider {
    
    @State static var coursesList = Array<Course>()
    @State static var activeView = "miei_corsi"
    @State static var selectedCourseID = 0
    
    static var previews: some View {
        MyCoursesView(
            activeView: $activeView,
            coursesList: $coursesList,
            selectedCourseID: $selectedCourseID
        )
    }
}
