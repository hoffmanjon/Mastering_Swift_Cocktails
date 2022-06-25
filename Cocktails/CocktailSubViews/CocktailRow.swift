//
//  CocktailRow.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/11/22.
//

import SwiftUI
import CachedAsyncImage
//This view is to layout the cocktails view within thew list view of the CocktailList page
struct CocktailRow: View {
    //creating a state variable to hold the information about the Cocktail
    @State var cocktail: Cocktail
    //The view to display
    var body: some View {
        //Creating a horizontal stack to layout the view
        HStack {
            //if the cocktail information contains information about an image to display, load it and display it
            if let strDrinkThumb = cocktail.strDrinkThumb {
                //loading in the image of the cocktail asynchronously
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
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.trailing, 40)
                
            } else  {//If there is no photo listed in the cocktail information, load default image
                Image(systemName: "photo").padding()
            }
            //Display the name of the cocktail
            Text(cocktail.strDrink)
        }
        
    }
}

/*struct CocktailRow_Previews: PreviewProvider {
 static var previews: some View {
 CocktailRow()
 }
 } */
