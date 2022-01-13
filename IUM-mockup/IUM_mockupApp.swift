//
//  IUM_mockupApp.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 08/01/22.
//

import SwiftUI

@main
struct IUM_mockupApp: App {
    
    @State var coursesList: [Int : Course] = [:]
    
    func testData() {
        self.coursesList[0] = Course(
            id: 0,
            courseName: "Interazione Uomo-Macchina",
            attendantName: "Prof. Emanuele Panizzi",
            accademicYear: "2021/2022",
            valutation: 4,
            subscribed: false
        )
        self.coursesList[1] = Course(
            id: 1,
            courseName: "Calcolo Differenziale",
            attendantName: "Prof. Nadia Ansini",
            accademicYear: "2018/2019",
            valutation: 1,
            subscribed: false
        )
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(coursesList: self.$coursesList)
                .onAppear(perform: self.testData)
        }
    }
}
