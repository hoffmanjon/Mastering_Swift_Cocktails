//
//  CocktailDetails.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/11/22.
//

import SwiftUI
import CachedAsyncImage
/*
 This view displays the details about a cocktail
 When the view is loaded it takes a Cocktail object that came from a cocktail list api.  This is a list of cocktails by either letter or ingredient.  We then use the cocktail id from that object to load the cocktail's detail from the cocktails details API
 */
struct CocktailDetails: View {
    //A state variable that contains the information about the cocktail to display
    @State var cocktail: Cocktail
    
    //The view to display
    var body: some View {
        //a vertical stack to format the informtaion
        VStack {
            //Put everyting in a scrollview so it will fit on smaller screens
            ScrollView(.vertical) {
                //If the cocktail has an image, load it asynconously
                if let strDrinkThumb = cocktail.strDrinkThumb {
                    CachedAsyncImage(url: URL(string: strDrinkThumb)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .scaledToFit()
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 300, height: 300)
                    .background(Color.gray)
                    .padding(.top, 15)
                    
                } else  {
                    //If the cocktail does not contain an image, display the default
                    Image(systemName: "photo").padding()
                }
               
                //Lets you know if the drink contains alcohol or not
                if let alcoholic = cocktail.strAlcoholic {
                    Text(alcoholic)
                        .font(.title)
                }
                //Display each of the ingredients and amounts for the cocktail
                ForEach(cocktail.ingredients, id: \.self){ ingredientStr in
                    Text(ingredientStr)
                }
                //Display the instructions for maike the cocktail
                if let instructions = cocktail.strInstructions {
                    Text(instructions)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
        }
        .navigationTitle(cocktail.strDrink)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            Task {
                //Load the information about the cocktail from the api using the ID of the drink.
                if let cocktailsFromApi = await CocktailService.load(CocktailServiceCall.byid, parameter: cocktail.idDrink) {
                    if cocktailsFromApi.drinks.count > 0 {
                        self.cocktail = cocktailsFromApi.drinks[0]
                    }
                }
                
            }
        }
    }
}

/*
 struct CocktailDetails_Previews: PreviewProvider {
 static var previews: some View {
 CocktailDetails()
 }
 }
 */
