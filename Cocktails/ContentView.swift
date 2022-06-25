//
//  ContentView.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/10/22.
//

import SwiftUI
import CoreData
/**
 This is the main view what will be shown when the app for starts up.   It will show the following items:
 1.  An horizonally scrollable list of popular drinks.  Tap anyone to see the details for the drink
 2.  An horizonally scrollable list of ingredients that are in your bar.  Tap anyone to see a list of drinks that contain that ingredient
 3.  A Button to to see a list of drinks that start with a selectable letter
 4.  A button to show a random drink
 This view will appear within a tab view
 */
struct ContentView: View {
    //List of pupular cocktails to show
    @State var cocktails: [Cocktail] = [Cocktail]()
    
    //List of ingredients in your bar
    @State var ingredients: [String] = [String]()
    
    //Random cocktail to show if you press the random button
    @State private var randomCocktail: Cocktail?
    
    //Core Data variables
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var barItems: FetchedResults<Bar_Item>
    
    //The is the main the view that is display when the app first starts
    var body: some View {
        
        //We need to wrap this view within a navigation view so we can have links to other views
        NavigationView {
            
            //Adding a scroll view so this view will fit on smaller screns
            ScrollView(.vertical) {
                //Having the view vertically stacked
                VStack(alignment: .leading) {
                    //Set up the horizonal list of popular drinks
                    Text("Popular")
                        .foregroundColor(Color.gray)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(cocktails, id: \.self) { cocktail in
                                NavigationLink(destination: CocktailDetails(cocktail: cocktail)) {
                                    CocktailColumn(cocktail: cocktail)
                                }
                                Divider()
                            }
                            
                        }
                        .frame(height: 200)
                    }
                    //Setting up the horizonal list of ingredients that are in your bar
                    Text("By Ingredient")
                        .foregroundColor(Color.gray)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(ingredients, id: \.self) { ingredient in
                                NavigationLink(destination: CocktailList(apiCall: .byingredint, parameter: ingredient)) {
                                    IngredientColumn(ingredient: ingredient)
                                }
                                Divider()
                            }
                            
                        }
                        .frame(height: 200)
                    }
                    //Horizontal stack to place two buttons side by side
                    HStack(alignment: .center) {
                        //Button to veiw drinks by first character
                        NavigationLink(destination: CocktailList(apiCall: .byletter, parameter: "A")) {
                            VStack {
                                Image("letterA").frame(width: 150, height: 150)
                                Text("By Letter").font(.caption)
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.gray)
                        .padding(.bottom, 100)
                        
                        //spacer for fomatting
                        Spacer()
                        
                        //Button to view random drink
                        if let randomCocktail = randomCocktail {
                            NavigationLink(destination: CocktailDetails(cocktail: randomCocktail)) {
                                VStack {
                                    Image("random").frame(width: 150, height: 150)
                                    Text("Random Cocktail").font(.caption)
                                }
                            }
                            .buttonStyle(.bordered)
                            .tint(.gray)
                            .padding(.bottom, 100)
                        }
                    }.padding()
                    
                    
                    Spacer()
                }
                .frame(width: .infinity, height: .infinity, alignment: .top)
                //When the view appears load information
                .onAppear() {
                    //Load list of popular drinks
                    Task {
                        if let cocktailsFromApi = await CocktailService.load(.popular, parameter: "") {
                            self.cocktails = cocktailsFromApi.drinks
                        }
                    }
                    //Load list of ingredients in your bar
                    Task {
                        ingredients.removeAll()
                        for barItem in barItems {
                            if let ingredient = barItem.ingredient {
                                ingredients.append(ingredient)
                            }
                        }
                    }
                    //Load a random cocktail
                    Task {
                        if let randomReturn = await CocktailService.load(.random, parameter: "") {
                            if randomReturn.drinks.count > 0 {
                                randomCocktail = randomReturn.drinks.first
                            }
                        }
                    }
                }
            }
        }
    }
}

/*struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 } */
