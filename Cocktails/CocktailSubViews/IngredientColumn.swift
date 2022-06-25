//
//  IngredientColumn.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/12/22.
//

import SwiftUI
import CachedAsyncImage
//This view is to layout the ingredients view for the horizontal scroll view on the ContentView page
struct IngredientColumn: View {
    //Creating a state variable to store the name of the ingredient
    @State var ingredient: String
    //This is the view to display
    var body: some View {
        //Creating a vertical stack to layout the information
        VStack {
            //loading in the image of the ingredient asynchronously
            CachedAsyncImage(url: URL(string: IngredientService.imageUrlfor(ingredient, imageSize: IngredientImagesSize.mediumimage))) { phase in
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
            
            //display the name of the ingredient
            Text(ingredient)
                .foregroundColor(Color.gray)
        }
    }
}

/*struct CocktailRow_Previews: PreviewProvider {
 static var previews: some View {
 CocktailRow()
 }
 } */
