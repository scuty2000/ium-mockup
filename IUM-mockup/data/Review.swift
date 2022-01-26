//
//  Review.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 26/01/22.
//

import Foundation

struct Review: Identifiable {

    var id: Int
    var courseID: Int
    var date: String
    var username: String
    var title: String
    var description: String
    var valutation: Int
    
    var upvote: Int
    var downvote: Int

}
