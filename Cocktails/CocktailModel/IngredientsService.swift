//
//  IngredientsService.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/12/22.
//

import Foundation
/*
 This struct retrieves a list of ingredients from one of the cocktail API's
It starts off by creating the URL to call, and then retrieves the data using the URL
It then uses the JSON decoder to pull parse the JSON data for the ingredients
 */
struct IngredientService {
    static func load(_ call: IngredientServiceCall, parameter: String) async -> Ingredients? {
        let urlString = call.rawValue.appending(parameter).replacingOccurrences(of: "$key", with: ApiKey.apiKey.rawValue)
        guard let url = URL(string: urlString) else {
            return nil
        }
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let Ingredientss: Ingredients = try JSONDecoder().decode(Ingredients.self, from: data)
            return Ingredientss
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
            return nil
        }
    }
    
    static func imageUrlfor(_ ingredientName: String, imageSize: IngredientImagesSize) -> String {
        let name = ingredientName.replacingOccurrences(of: " ", with: "%20")
        return IngredientImagesUrl.imageurl.rawValue + name + imageSize.rawValue
    }
}

