//
//  Cocktail.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/10/22.
//

import Foundation

/*
 The Cocktails and Cocktail structs are used by the JSONDecoder to parse the cocktail lists that are returned from the Cocktails api.
 The Cocktails are the top level of the JSON data and it contains an array of Cocktail objects
 */
struct Cocktails: Decodable {
    let drinks: [Cocktail]
}

struct Cocktail: Decodable, Identifiable, Hashable {
    var id: String { idDrink }
    let idDrink: String
    let strDrink: String
    let strDrinkAlternate: String?
    let strTags: String?
    let strVideo: String?
    let strCategory: String?
    let strIBA: String?
    let strAlcoholic: String?
    let strGlass: String?
    let strInstructions: String?
    let strInstructionsES: String?
    let strInstructionsDE: String?
    let strInstructionsFR: String?
    let strInstructionsIT: String?
    let strDrinkThumb: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strImageSource: String?
    let strImageAttribution: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    var ingredients: [String] {
        var retString: [String] = [String]()
        if let measure = strMeasure1, let ingredient = strIngredient1 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure2, let ingredient = strIngredient2 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure3, let ingredient = strIngredient3 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure4, let ingredient = strIngredient4 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure5, let ingredient = strIngredient5 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure6, let ingredient = strIngredient6 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure7, let ingredient = strIngredient7 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure8, let ingredient = strIngredient8 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure9, let ingredient = strIngredient9 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure10, let ingredient = strIngredient10 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure11, let ingredient = strIngredient11 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure12, let ingredient = strIngredient12 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure13, let ingredient = strIngredient13 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure14, let ingredient = strIngredient14 {
            retString.append("\(measure)  \(ingredient)")
        }
        if let measure = strMeasure15, let ingredient = strIngredient15 {
            retString.append("\(measure)  \(ingredient)")
        }

        return retString
    }
}
