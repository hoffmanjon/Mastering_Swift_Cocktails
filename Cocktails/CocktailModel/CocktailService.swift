//
//  Cocktails.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/10/22.
//

import Foundation

/*
 This struct retrieves a list of cocktails from one of the cocktail API's
 It starts off by creating the URL to call, and then retrieves the data using the URL
 It then uses the JSON decoder to pull parse the JSON data for the cocktails
 */
struct CocktailService {
    static func load(_ call: CocktailServiceCall, parameter: String) async -> Cocktails? {
        let parameter = parameter.replacingOccurrences(of: " ", with: "%20")
        let urlString = call.rawValue.appending(parameter).replacingOccurrences(of: "$key", with: ApiKey.apiKey.rawValue)
        guard let url = URL(string: urlString) else {
            return nil
        }
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let cocktails: Cocktails = try JSONDecoder().decode(Cocktails.self, from: data)
            return cocktails
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
            return nil
        }
    }
}
