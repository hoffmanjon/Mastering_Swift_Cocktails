//
//  Ingredients.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/12/22.
//

import Foundation

/*
 The ingredients and ingredient structs are used by the JSON Decoder to parse the list of ingredients coming back from the api calls.   The Ingredients are the top level object which simply contains an array of ingredient objects
 */
struct Ingredients: Decodable {
    let drinks: [Ingredient]
}

struct Ingredient: Decodable, Identifiable, Hashable {
    var id: UUID { UUID() }
    let strIngredient1: String?
    
    static func <(lhs: Ingredient, rhs: Ingredient) -> Bool {
        if let lIngredient = lhs.strIngredient1, let rIngredient = rhs.strIngredient1 {
            return lIngredient < rIngredient
        }
        return false
    }
}

/*
 The ingredientsSelection struct is used in the BarView view to show which infredients are currently select as being in your bar.
 */
struct IngredientSelection: Decodable, Identifiable, Hashable, Comparable {
    var id: UUID { UUID() }
    let strIngredient1: String
    var selected: Bool = false
    
    static func <(lhs: IngredientSelection, rhs: IngredientSelection) -> Bool {
        return lhs.strIngredient1 < rhs.strIngredient1
    }
}


