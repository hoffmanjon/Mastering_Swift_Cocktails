//
//  CocktailAPI.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/12/22.
//

import Foundation

//My API key, changed to a generic key prior to uploading to GitHub
enum ApiKey: String {
    case apiKey = "v1/1"
}


//List of URLs to use for retrieve lists of cocktails or details about a cocktail
enum CocktailServiceCall: String {
    case random = "https://www.thecocktaildb.com/api/json/$key/random.php"
    case byletter = "https://www.thecocktaildb.com/api/json/$key/search.php?f="
    case byingredint = "https://www.thecocktaildb.com/api/json/$key/filter.php?i="
    case byid = "https://www.thecocktaildb.com/api/json/$key/lookup.php?i="
    case tenrandom = "https://www.thecocktaildb.com/api/json/$key/randomselection.php"
    case popular = "https://www.thecocktaildb.com/api/json/$key/popular.php"
}

//List of URLs to use to retrieve the ingredient lists
enum IngredientServiceCall: String {
    case ingredientslist = "https://www.thecocktaildb.com/api/json/$key/list.php?i=list"
}

//URL to use to retrieve the images for ingredients
enum IngredientImagesUrl: String {
    case imageurl = "https://www.thecocktaildb.com/images/ingredients/"
}

//Image size suffix for the ingredients images url
enum IngredientImagesSize: String {
    case smallimage = "-Small.png"
    case mediumimage = "-Medium.png"
    case largeimage = ".png"
}
