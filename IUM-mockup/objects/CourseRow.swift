//
//  CourseRow.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 23/01/22.
//

import SwiftUI

struct CourseRow: View {

    @Binding var isShowingDetailView: Bool
    @Binding var selectedCourseID: Int
    @Binding var subscribedCourse: Bool
    
    var course: Course

    var body: some View {
        Button(action: {
            withAnimation {
                self.isShowingDetailView = true
                self.selectedCourseID = course.id
                self.subscribedCourse = course.subscribed
            }
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
                            .font(.system(size: 19))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                        Text("\(course.relativeYear) / \(course.semester), \(course.channel)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .fontWeight(Font.Weight.regular)
                        HStack(spacing: 0) {
                            Text("Anno Accademico:")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .fontWeight(Font.Weight.regular)
                                .padding(.trailing, 5)
                            Text(course.accademicYear)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .fontWeight(Font.Weight.regular)
                        }
                        Text("\(course.cfu)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .fontWeight(Font.Weight.regular)
                            .padding(.bottom, 5)
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
                        .padding(.top, 10)

                    }
                    
//                    Image(systemName: "arrow.up.right.square.fill")
//                        .foregroundColor(.white)
//                        .imageScale(.large)
//                        .offset(y: 45)
                    
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
