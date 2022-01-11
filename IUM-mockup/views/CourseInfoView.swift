//
//  CourseInfoView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 11/01/22.
//

import SwiftUI

struct CourseInfoView: View {
    
    @Binding var coursesList: [Int : Course]
    @Binding var selectedCourseID: Int
    
    @Binding var navigationBarTitle: String
    
    @State var selectedIndex: Int = 0
    
    func setTitleBar() { self.navigationBarTitle = self.coursesList[self.selectedCourseID]!.courseName }
    
    var body: some View {
        VStack() {
            HStack(alignment: .center, spacing: 0){
                Text(self.coursesList[self.selectedCourseID]!.attendantName)
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
                    ForEach(0..<self.coursesList[self.selectedCourseID]!.valutation) { _ in
                        Image(systemName: "star.fill")
                            .imageScale(.medium)
                            .foregroundColor(.brown)
                    }
                    ForEach(0..<5 - self.coursesList[self.selectedCourseID]!.valutation) { _ in
                        Image(systemName: "star")
                            .imageScale(.medium)
                            .foregroundColor(.brown)
                    }
                }
            }
            Picker("", selection: self.$selectedIndex) {
                Text("Informazioni").tag(0)
                Text("Materiali").tag(2)
                Text("Recensioni").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
        }
        .padding(.trailing)
        .padding(.leading)
        .onAppear(perform: { setTitleBar() })
        .frame(alignment: .top)
    }
}
