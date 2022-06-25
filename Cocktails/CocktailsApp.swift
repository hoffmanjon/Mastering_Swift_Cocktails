//
//  CocktailsApp.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/10/22.
//

import SwiftUI

@main
struct CocktailsApp: App {
    //For core data
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            MainView().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
