//
//  ContentView.swift
//  IUM-mockup
//
//  Created by Luca Scutigliani on 08/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var showMenu = false
    @State var activeView = "miei_corsi"
    @State var navigationBarTitle = "I Miei Corsi"
    
    init() {
        
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().barStyle = .default
        
    }
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.startLocation.x > $0.location.x {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .disabled(self.showMenu ? true : false)
                    if(self.showMenu) {
                        MenuView(showMenu: self.$showMenu, activeView: self.$activeView, navigationBarTitle: self.$navigationBarTitle)
                            .frame(width: geometry.size.width/2.3)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
            }
            .navigationBarTitle(Text(self.navigationBarTitle), displayMode: .inline)
            .navigationBarItems(leading: (
            
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
            
            ))
            
        }
        
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        Text("Sidemenu mockup test")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
