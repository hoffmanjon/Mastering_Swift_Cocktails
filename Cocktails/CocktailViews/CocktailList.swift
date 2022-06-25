//
//  CocktailList.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/11/22.
//

import SwiftUI
import CoreData
/**
 This view displays a list of cocktails in a list view.
 The format for the individual items in the list view is done in the CocktailRow view
 This view will display the list of cocktails by ingredient or by first letter, depending on which options you choose.  It will also let you change the parameter (ingredient or letter) once on the page
 */

struct CocktailList: View {
    //The api used to retrieve the list of cocktails
    let apiCall: CocktailServiceCall
    //The parameter to use for the api call
    @State var parameter: String
    //A state variable to hold the list of cocktails displayed
    @State var cocktails: [Cocktail] = [Cocktail]()
    //A state varible that is used to store the list of ingredients in your bar if you selected to display the list of cocktails by ingredients
    @State private var ingredients: [String] = [String]()
    
    //Fetch the list of ingredients saved in the Core Data database.  This is the list of ingredients that you have save as ingredients in your bar
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var barItems: FetchedResults<Bar_Item>
    
    //The view to display
    var body: some View {
        VStack {
            //Display the title for the list and the picker based on what API call is used to select the list of cocktails.
            if apiCall == CocktailServiceCall.byletter {
                Text("Drinks Beginning With").font(.headline)
                Picker("",selection: $parameter) {
                    ForEach(characters, id: \.self) {
                        Text($0).font(.title)
                    }
                }
                .pickerStyle(.menu)
                .onReceive([self.parameter].publisher.first()) { (value) in
                    retrieveCocktails()
                }
            } else if apiCall == CocktailServiceCall.byingredint {
                Text("Drinks Containing").font(.headline)
                Picker("",selection: $parameter) {
                    ForEach(ingredients, id: \.self) {
                        Text($0).font(.title)
                    }
                }
                .pickerStyle(.menu)
                .onReceive([self.parameter].publisher.first()) { (value) in
                    retrieveCocktails()
                }
            }
            //The list view that displays the cocktails
            List(cocktails) { cocktail in
                HStack {
                    //Navigation link so when you selelct a cocktail it will take you to the cocktails details page
                    NavigationLink(destination: CocktailDetails(cocktail: cocktail)) {
                        //Uses the CocktailRow view to display the cocktail within the list view
                        CocktailRow(cocktail: cocktail)
                    }
                }
            }
            .onAppear() {
                //retrive the cocktail list
                retrieveCocktails()
                Task {
                    //Store the list of ingredients in your bar to the ingredients state variable, which is used by the picker if we are displaying the cocktails by ingredient.
                    var cnt = 0
                    ingredients.removeAll()
                    for barItem in barItems {
                        if let ingredient = barItem.ingredient {
                            cnt+=1
                            ingredients.append(ingredient)
                        }
                    }
                }
                
            }
        }
    }
    
    //This function retrieves the list of cocktails, based on the api call and parameter for the call.
    private func retrieveCocktails() {
        Task {
            //Use the load function from the CocktailService struct to retrieve the cocktail list
            if let cocktailsFromApi = await CocktailService.load(apiCall, parameter: parameter) {
                self.cocktails = cocktailsFromApi.drinks
            }
        }
    }
}
/*struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 } */
