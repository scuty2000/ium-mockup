//
//  MenuView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 08/01/22.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var showMenu: Bool
    @Binding var activeView: String
    @Binding var navigationBarTitle: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                
                Button(action: {
                    activeView = "miei_corsi"
                    navigationBarTitle = "I Miei Corsi"
                    withAnimation {
                        self.showMenu = false
                    }
                }) {
                    if activeView == "miei_corsi" {
                        Image(systemName: "books.vertical.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("I miei corsi")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.black)
                    } else {
                        Image(systemName: "books.vertical.circle")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("I miei corsi")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
                
            }
            .padding(.top, 10)
            HStack {
                Button(action: {
                    activeView = "lista_corsi"
                    navigationBarTitle = "Ricerca Corsi"
                    withAnimation {
                        self.showMenu = false
                    }
                }) {
                    if(self.activeView == "lista_corsi") {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Ricerca corsi")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.black)
                    } else {
                        Image(systemName: "magnifyingglass.circle")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Ricerca corsi")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
            }
            .padding(.top, 5)
            HStack {
                Button(action: {
                    activeView = "impostazioni"
                    navigationBarTitle = "Impostazioni"
                    withAnimation {
                        self.showMenu = false
                    }
                }) {
                    if(self.activeView == "impostazioni") {
                        Image(systemName: "gearshape.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Impostazioni")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.black)
                    } else {
                        Image(systemName: "gearshape.circle")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Impostazioni")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
            }
            .padding(.top, 5)
            Spacer()
            Divider().background(.white)
            HStack {
                Button(action: {
                    activeView = "profile"
                    navigationBarTitle = "Gestione profilo"
                    withAnimation {
                        self.showMenu = false
                    }
                }) {
                    if(activeView == "profile") {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Profilo")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.black)
                    } else {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Profilo")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
            }
            .padding(.bottom, 10)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red:32/255, green: 32/255, blue: 32/255).edgesIgnoringSafeArea(.bottom))
    }
}
