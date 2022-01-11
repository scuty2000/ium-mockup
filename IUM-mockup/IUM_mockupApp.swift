//
//  IUM_mockupApp.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 08/01/22.
//

import SwiftUI

@main
struct IUM_mockupApp: App {
    
    @State var coursesList = Array<Course>()
    
    func testData() {
        self.coursesList.append(Course(
            id: 0,
            courseName: "Interazione Uomo-Macchina",
            attendantName: "Prof. Emanuele Panizzi",
            accademicYear: "2021/2022",
            valutation: 4,
            subscribed: true
        ))
        self.coursesList.append(Course(
            id: 1,
            courseName: "Calcolo Differenziale",
            attendantName: "Prof. Nadia Ansini",
            accademicYear: "2018/2019",
            valutation: 1,
            subscribed: false
        ))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(coursesList: self.$coursesList)
                .onAppear(perform: self.testData)
        }
    }
}
