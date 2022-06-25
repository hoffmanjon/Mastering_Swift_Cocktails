//
//  MainView.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/13/22.
//

import SwiftUI
/*
 This is the main view that sets up the tab view.
 The "Drinks" tab is linked to the ContentView()
 The "Bar" tab is linked to the BarView
 */
struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Drinks", image: "glass")
                }
            BarView()
                .tabItem {
                    Label("Bar", image: "bottle")
                }
            
        }
    }
    
}

/*
 struct MainView_Previews: PreviewProvider {
 static var previews: some View {
 MainView()
 }
 }
 */
