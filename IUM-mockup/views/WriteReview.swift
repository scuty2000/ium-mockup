//
//  WriteReview.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 27/01/22.
//

import SwiftUI

struct WriteReview: View {
    
    @State var anonymous = false
    @State var reviewStars = 3
    @State var reviewTitle = ""
    @State var reviewBody = "Descrizione recensione"
    
    @State var showingAlert = false
    
    @Binding var isWritingReview: Bool
    @Binding var reviewsList: [Review]
    
    var course: Course
    
    let placeholderString = "Descrizione recensione"
    
    var body: some View {
        
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    Text("Valutazione:")
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    ForEach(1...5, id: \.self) { id in
                        
                        Button(action: {
                            
                            reviewStars = id
                            
                        }) {
                            
                            if(id <= reviewStars) {
                                
                                Image(systemName: "star.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.brown)
                                
                            } else {
                                
                                Image(systemName: "star")
                                    .imageScale(.large)
                                    .foregroundColor(.brown)
                                
                            }
                            
                        }
                        
                    }
                    
                    
                }
                
                TextField (
                    "Titolo recensione",
                    text: self.$reviewTitle
                )
                    .textFieldStyle(.roundedBorder)
                
                VStack {
                    TextEditor(text: self.$reviewBody)
                        .frame(height:250, alignment: .center)
                        .foregroundColor(self.reviewBody == placeholderString ? Color(UIColor.systemGray3) : .primary)
                        .onTapGesture {
                            if self.reviewBody == placeholderString {
                                self.reviewBody = ""
                            }
                        }.padding(2)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(UIColor.systemGray), lineWidth: 0.1)
                )
                
                Divider()
                
                Toggle(isOn: self.$anonymous) {
                    Text("Recensione anonima")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("Scrivi Recensione")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
                                self.isWritingReview = false
                
                            }) {
                                
                                Text("Annulla")
                                
                            }, trailing: Button(action: {
                                
                                if(self.reviewTitle.isEmpty || self.reviewBody.isEmpty || self.reviewBody == placeholderString) {
                                    
                                    self.showingAlert = true
                                    
                                } else {
                                
                                    self.reviewsList.append(
                                        Review(id: (reviewsList.map { $0.id }.max() ?? 9999) + 1,
                                               courseID: self.course.id,
                                               date: "28/01/2022",
                                               username: self.anonymous ? "Tu (Anonimo)" : "Tu (Geronimo)",
                                               title: self.reviewTitle,
                                               description: self.reviewBody,
                                               valutation: self.reviewStars,
                                               upvote: 0,
                                               downvote: 0)
                                    
                                    )
                                    
                                    self.isWritingReview = false
                                    
                                }
                
                            }) {
                                
                                Text("Invia")
                                    .fontWeight(.bold)
                                
                            })
                            .alert("Devi compilare tutti i campi per lasciare una recensione!", isPresented: $showingAlert) {
                                        Button("Ok", role: .cancel) { }
                                    }
            
            }
            .onTapGesture {
                self.endEditing()
        }
        
        
    }
    
    private func endEditing() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        if(self.reviewBody == "") {
            self.reviewBody = placeholderString
        }
    }
    
}
