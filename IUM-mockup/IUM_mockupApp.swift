//
//  IUM_mockupApp.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 08/01/22.
//

import SwiftUI

@main
struct IUM_mockupApp: App {
    
    @State var subscribedCourses = Array<Course>()
    
    func testData() {
        self.subscribedCourses.append(Course(
            id: 0,
            courseName: "Interazione Uomo-Macchina"
        ))
    }
    
    init() {
        
        testData()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(subscribedCourses: self.$subscribedCourses)
        }
    }
}
