//
//  Course.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 09/01/22.
//

import Foundation

struct Course: Identifiable {
    
    var id: Int
    var courseName: String
    var attendantName: String
    var accademicYear: String
    
    var valutation: Int
    var subscribed: Bool
    
}
