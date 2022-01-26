//
//  IUM_mockupApp.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 08/01/22.
//

import SwiftUI

@main
struct IUM_mockupApp: App {
    
    @State var votedReviews: [Int : Int] = [:]
    @State var coursesList: [Int : Course] = [:]
    @State var reviewsList: [Review] = []
    
    func loadFile(fileName: String) -> String? {
        
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "tsv") {
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
        
        let reviews: String = loadFile(fileName: "reviews") ?? ""
        
        reviews.split(whereSeparator: \.isNewline).forEach { reviewLine in
            
            let cols = reviewLine.split(separator: "\t")
            let id = Int(cols[0]) ?? 9999
            
            var date = ""
            String(cols[2]).split(separator: "-").forEach { dateElement in
        
                date = "\(dateElement)/\(date)"
                
            }
            
            let start = date.index(date.startIndex, offsetBy: 0)
            let end = date.index(date.startIndex, offsetBy: 9)
            let range = start...end
            
            date = String(date[range])
            
            self.reviewsList.append(
            
                Review(
                    id: id,
                    courseID: Int(cols[1]) ?? 0,
                    date: date,
                    username: String(cols[3]),
                    title: String(cols[4]),
                    description: String(cols[5]),
                    valutation: Int(cols[6]) ?? 0,
                    upvote: Int(cols[7]) ?? 0,
                    downvote: Int(cols[8]) ?? 0
                )
            
            )
            
            self.votedReviews[id] = 0
            
        }
        
        let courses: String = loadFile(fileName: "corsi") ?? ""
        
        courses.split(whereSeparator: \.isNewline).forEach { courseLine in
            
            let cols = courseLine.split(separator: "\t")
            let id = Int(cols[0]) ?? 9999
            
            let name = String(cols[1])
            var abbreviation = ""
            
            if(name.components(separatedBy: " ").filter { !($0 == "II") && !($0 == "I") }.count > 1) {
                abbreviation = (Array(name.filter { char in char.isUppercase }.map(String.init)).joined(separator: ".") + ".").replacingOccurrences(of: ".I.I.", with: ". 2").replacingOccurrences(of: ".I.", with: ". 1")
            } else {
                abbreviation = name.replacingOccurrences(of: "II", with: "2").replacingOccurrences(of: "I", with: "1")
            }
            
            self.coursesList[id] = Course(
                id: id,
                courseName: String(cols[1]),
                attendantName: String(cols[3]),
                accademicYear: String(cols[5]),
                abbreviatedName: abbreviation,
                cfu: String(cols[9]),
                relativeYear: String(cols[8]),
                semester: String(cols[7]),
                channel: String(cols[4]),
                description: String(cols[10]),
                valutation: Int(cols[6]) ?? 5,
//                subscribed: id % 2 == 0
                subscribed: false
            )
            
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(coursesList: self.$coursesList, reviewsList: self.$reviewsList, votedReviews: self.$votedReviews)
                .onAppear(perform: self.testData)
        }
    }
}
