//
//  CocktailColumn.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/12/22.
//

import SwiftUI
import CachedAsyncImage
//This view is to layout the cocktails view for the horizontal scroll view on the ContentView page
struct CocktailColumn: View {
    //Creating a state variable to hole the cocktail information
    @State var cocktail: Cocktail
    //The view to display
    var body: some View {
        //Creating a vertical stack to layout the information
        VStack {
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
                .frame(width: 150, height: 150)
                .padding(.bottom, 10)
                
            } else  { //If there is no photo listed in the cocktail information, load default image
                Image(systemName: "photo").padding()
            }
            //Display the cocktail name
            Text(cocktail.strDrink)
                .foregroundColor(Color.gray)
        }
    }
}

/*struct CocktailRow_Previews: PreviewProvider {
 static var previews: some View {
 CocktailRow()
 }
 } */
