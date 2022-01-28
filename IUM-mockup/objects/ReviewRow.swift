//
//  ReviewRow.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 26/01/22.
//

import SwiftUI

struct ReviewRow: View {
    var review: Review
    
    let green = Color(red: 30/255, green: 168/255, blue: 150/255)
    let darkGray = Color(red: 32/255, green: 32/255, blue: 32/255)
    let red = Color(red: 244/255, green: 78/255, blue: 63/255)
    
    @Binding var votedReviews: [Int : Int]

    var body: some View {
        return VStack {
            HStack(alignment: .center) {
                
                VStack(alignment: .leading, spacing: 0){
                    
                    HStack(alignment: .center, spacing: 0){
                        Text(review.title)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .fontWeight(.heavy)
                        Spacer()
                        ValutationObject(valutation: review.valutation)
                    }
                    
                    Text("\(review.username) - \(review.date)")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .fontWeight(Font.Weight.light)
                        .padding(.bottom, 20)

                    Text(review.description)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .fontWeight(Font.Weight.regular)
                    
                }
                
            }
            .padding(.bottom, 10)
            
            HStack(spacing: 10) {
                
                Button(action: {
                    if(votedReviews[review.id] == 1) {
                        votedReviews[review.id] = 0
                    } else {
                        votedReviews[review.id] = 1
                    }
                }) {
                    
                    HStack (spacing: 1) {
                    
                        if(votedReviews[review.id] == nil || votedReviews[review.id] == 0 || votedReviews[review.id] == 2) {
                            
                            Image(systemName: "arrow.up.square")
                                .font(Font.system(size: 30))
                                .tint(green)
                            
                        } else {
                            
                            Image(systemName: "arrow.up.square.fill")
                                .font(Font.system(size: 30))
                                .tint(green)
                            
                        }
                        
                        
                        Text("\(votedReviews[review.id] == 1 ? review.upvote + 1 : review.upvote)")
                            .foregroundColor(green)
                        
                    }
                    
                }
                
                Button(action: {
                    if(votedReviews[review.id] == 2) {
                        votedReviews[review.id] = 0
                    } else {
                        votedReviews[review.id] = 2
                    }
                }) {
                    
                    HStack (spacing: 1) {
                    
                        if(votedReviews[review.id] == nil || votedReviews[review.id] == 0 || votedReviews[review.id] == 1) {
                        
                            Image(systemName: "arrow.down.square")
                                .font(Font.system(size: 30))
                                .tint(red)
                            
                        } else {
                            
                            Image(systemName: "arrow.down.square.fill")
                                .font(Font.system(size: 30))
                                .tint(red)
                            
                        }
                        
                        Text("\(votedReviews[review.id] == 2 ? review.downvote + 1 : review.downvote)")
                            .foregroundColor(red)
                        
                    }
                    
                }
                
                Spacer()
                
            }.padding(.bottom, 5)
            
        }
//        .frame(height: 170, alignment: .leading)
//        .background(RoundedRectangle(cornerRadius: 8)
//                        .stroke(review.valutation > 3 ? green : red)
//                        .shadow(color: review.valutation >= 3 ? green : red, radius: 3))
//
//        .padding(.leading)
//        .padding(.trailing)
        .padding(.top, 5)
        
    }
    
}

struct ValutationObject: View {
    
    let valutation: Int
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<valutation) { _ in
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.brown)
            }
            ForEach(0..<5 - valutation) { _ in
                Image(systemName: "star")
                    .imageScale(.medium)
                    .foregroundColor(.brown)
            }
        }
        
    }
    
}
