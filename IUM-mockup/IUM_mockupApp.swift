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
    
    func loadFile() -> String? {
        
        if let filepath = Bundle.main.path(forResource: "corsi", ofType: "tsv") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    func testData() {
        let courses: String = loadFile() ?? ""
        
        courses.split(whereSeparator: \.isNewline).forEach { courseLine in
            
            let cols = courseLine.split(separator: "\t")
            let id = Int(cols[0]) ?? 9999
            
            print("\n\(id)")
            cols.forEach {col in
                print("\t\(col)")
            }
            
            let name = String(cols[1])
            var abbreviation = ""
            
            if(name.components(separatedBy: " ").count > 1) {
                abbreviation = (Array(name.filter { char in char.isUppercase }.map(String.init)).joined(separator: ".") + ".").replacingOccurrences(of: "I.I.", with: "2.").replacingOccurrences(of: ".I.", with: ".1.")
            } else {
                abbreviation = name
            }
            print(abbreviation)
            
            self.coursesList[id] = Course(
                id: id,
                courseName: String(cols[1]),
                attendantName: String(cols[3]),
                accademicYear: String(cols[5]),
                abbreviatedName: abbreviation,
                description: String(cols[10]),
                valutation: Int(cols[6]) ?? 5,
                subscribed: id % 2 == 0
            )
            
        }
        
        print(self.coursesList.count)
        
//        self.coursesList[0] = Course(
//            id: 0,
//            courseName: "Interazione Uomo-Macchina",
//            attendantName: "Prof. Emanuele Panizzi",
//            accademicYear: "2021/2022",
//            abbreviatedName: "I.U.M.",
//            description: "Lorem ipsum dolor sit amet",
//            valutation: 4,
//            subscribed: true
//        )
//        self.coursesList[1] = Course(
//            id: 1,
//            courseName: "Calcolo Differenziale",
//            attendantName: "Prof. Nadia Ansini",
//            accademicYear: "2018/2019",
//            abbreviatedName: "C. Differenziale",
//            description: "Lorem ipsum dolor sit amet",
//            valutation: 1,
//            subscribed: false
//        )
        
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(coursesList: self.$coursesList)
                .onAppear(perform: self.testData)
        }
    }
}
