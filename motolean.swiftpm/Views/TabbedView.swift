//
//  SwiftUIView.swift
//  
//
//  Created by Farid Azhari on 17/04/23.
//

import SwiftUI

struct TabbedView: View {
    @State private var currentTab = 0
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    var body: some View {
        NavigationView{
            TabView(selection: $currentTab){
                TrackView()
                    .tabItem{
                        Label("Record", systemImage: "record.circle")
                    }
                InfoView()
                    .tabItem{
                        Label("Info", systemImage: "info.circle")
                            
                    }
                    
            }          //  .tabViewStyle(PageTabViewStyle())
            .background(Color.blue)
            .gesture(DragGesture())
           
            
        }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
