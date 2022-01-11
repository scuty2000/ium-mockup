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
    @State var selectedCourseID = 0
    
    @Binding var coursesList: Array<Course>
    
    init(coursesList: Binding<Array<Course>>) {
        
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().barStyle = .default
        
        self._coursesList = coursesList
        
    }
    
    func getNavigationBarTitle(activeView: String) -> String {
        
        switch(activeView) {
        case("miei_corsi"):
            return "I Miei Corsi"
        case("lista_corsi"):
            return "Ricerca Corsi"
        case("impostazioni"):
            return "Impostazioni"
        case("profile"):
            return "Profilo"
        default:
            return "unknown_view"
        }
        
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
                    ContainerView(
                        showMenu: self.$showMenu,
                        activeView: self.$activeView,
                        coursesList: self.$coursesList,
                        selectedCourseID: self.$selectedCourseID
                    )
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .offset(x: self.showMenu ? geometry.size.width/2.3 : 0)
                    
                    if(self.showMenu) {
                        MenuView(showMenu: self.$showMenu, activeView: self.$activeView, navigationBarTitle: self.$navigationBarTitle)
                            .frame(width: geometry.size.width/2.3)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
            }
            .navigationBarTitle(Text(self.getNavigationBarTitle(activeView: activeView)), displayMode: .inline)
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

struct ContentView_Previews: PreviewProvider {
    
    @State static var coursesList = Array<Course>()
    
    static var previews: some View {
        Group {
            ContentView(coursesList: $coursesList)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
