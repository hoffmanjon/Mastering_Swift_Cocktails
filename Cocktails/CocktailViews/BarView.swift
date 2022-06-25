//
//  BarView.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/13/22.
//

import SwiftUI
//This view display the list of ingredients that can be added to your bar and allows you to add them to your bar list.  You can also search the ingredients list to make it easier to find the one you are looking for
struct BarView: View {
    //A state variable hold the list of ingredients that can be added to your bar
    @State var ingredients: [IngredientSelection] = [IngredientSelection]()
    
    //A state varible to hold the text within the search bar
    @State private var searchText = ""
    //A state boolean to avoid loading in the ingredients list more than once.
    @State private var firstAppear = true
    
    //a variable that contains the filtered list of ingredients based on the search text.  If the search text is empty return the full ingredient list otherwise return a filted list based on the search text
    var filteredResults: [IngredientSelection] {
        if searchText.isEmpty {
            return ingredients
        } else {
            return ingredients.filter { $0.strIngredient1.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    //the view to display
    var body: some View {
        //set up the navigation view
        NavigationView {
            //Create the list view
            List(filteredResults) { ingredient in
                    HStack {
                        IngredientRow(ingredient: ingredient)
                    }
            }
            .searchable(text: $searchText)
            .navigationTitle("Ingredients")
            .onAppear() {
                Task {
                    //if it is the first time loading the ingredients, then load them
                    if firstAppear {
                        self.firstAppear = false
                        //Load the list of ingredients from the API using the load method from the IngredientsService struct
                        if let ingredientsFromApi = await IngredientService.load(IngredientServiceCall.ingredientslist, parameter: "") {
                            //For each ingredient, load it inot the ingredients array
                            for ingredient in ingredientsFromApi.drinks {
                                if let ingredientName = ingredient.strIngredient1 {
                                    ingredients.append(IngredientSelection(strIngredient1: ingredientName, selected: false))
                                }
                            }
                            //Sort the ingredients list so everything appears in alphabetical order
                            ingredients.sort()
                        }
                    }
                }
            }
        }
        
    }
}
/*
 struct BarView_Previews: PreviewProvider {
 static var previews: some View {
 BarView()
 }
 }
 */
