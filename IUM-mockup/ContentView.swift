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
    
    @Binding var coursesList: [Int : Course]
    
    init(coursesList: Binding<[Int : Course]>) {
        
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().barStyle = .default
        
        self._coursesList = coursesList
        
    }
    
    func getNavigationBarTitle(activeView: String) {
        
        switch(activeView) {
            case("miei_corsi"):
                self.navigationBarTitle = "I Miei Corsi"
                return
            case("lista_corsi"):
                self.navigationBarTitle = "Ricerca Corsi"
                return
            case("impostazioni"):
                self.navigationBarTitle = "Impostazioni"
                return
            case("profile"):
                self.navigationBarTitle = "Profilo"
                return
            default:
                self.navigationBarTitle =  "unknown_view"
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
                        selectedCourseID: self.$selectedCourseID,
                        navigationBarTitle: self.$navigationBarTitle
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
            .navigationBarTitle(Text(self.navigationBarTitle), displayMode: .inline)
            .navigationBarItems(leading: self.activeView == "course_info" ? AnyView(self.backButton) : AnyView(self.hamburgerButton))
            
        }
        
    }
    
    var hamburgerButton: some View {
        Button(action: {
            withAnimation {
                self.showMenu.toggle()
            }
        }) {
            Image(systemName: "line.horizontal.3")
                .imageScale(.large)
                .foregroundColor(.gray)
        }
    }
    
    var backButton: some View {
        Button(action: {
            print("back")
        }) {
            Image(systemName: "arrowtriangle.backward.fill")
                .imageScale(.large)
                .foregroundColor(.gray)
            Text("Back")
                .foregroundColor(.gray)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    
    @State static var coursesList: [Int : Course] = [:]
    
    static var previews: some View {
        Group {
            ContentView(coursesList: $coursesList)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
