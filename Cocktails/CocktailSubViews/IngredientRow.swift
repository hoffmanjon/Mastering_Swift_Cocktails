//
//  IngredientRow.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/13/22.
//

import SwiftUI
import CachedAsyncImage
import CoreData
//This view is to layout the ingredients view within thew list view of the BarView page
struct IngredientRow: View {
    //A state variable to hold the list of ingredients
    @State var ingredient: IngredientSelection
    //Fetch the list of ingredients saved in the Core Data database.  This is the list of ingredients that you have save as ingredients in your bar
    @FetchRequest(sortDescriptors: []) var barItems: FetchedResults<Bar_Item>
    @Environment(\.managedObjectContext) private var viewContext
    
    //The view to display
    var body: some View {
        //Creating a horizontal stack to layout the view
        HStack {
            //Load the image of the ingredient asynchronously
            CachedAsyncImage(url: URL(string: IngredientService.imageUrlfor(ingredient.strIngredient1, imageSize: .mediumimage))) { phase in
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
            .padding(.trailing, 40)
            
            //Display the name of the ingredient
            Text(ingredient.strIngredient1)
            Spacer()
            //create a button to add or remove item from the ingredients
            Button(action: {
                buttonPressedForItem()
            }, label: {
                ingredient.selected ? Image(systemName: "minus.circle") : Image(systemName: "plus.app")
            })
        }
        .onAppear() {
            //See if the ingredient is in the list stored in Core Data as an ingredient in your bar
            self.ingredient.selected = doesBarContainItem()
        }
    }
    
    //The function to lookup in the core data database to see if it includes this ingredient
    private func doesBarContainItem() -> Bool {
        //Create the fetch request
        let request: NSFetchRequest<Bar_Item> = Bar_Item.fetchRequest()
        //Create the queue to pull back only rows that match the ingredient name
        request.predicate = NSPredicate(format: "ingredient ==[cd] %@", ingredient.strIngredient1)
        request.fetchLimit = 1

        do {
            //if the results contain information then it is in the core data database
            //if no results are returned then the item is not in the core data database
            if let _ = try viewContext.fetch(request).first {
                return true
            }
            return false
        } catch {
            debugPrint("Error \(error)")
            return false
        }
    }
    
    //If the button is pressed and the item is in the database, then remove it.
    //If the button is pressed and the item is not in the database, then add it
    private func buttonPressedForItem() {
        doesBarContainItem() ? removeBarItem() : addBarItem()
    }
    
    //This function will remove the item from the database
    private func removeBarItem() {
        //We need to start off by fetching the object from the database
        let fetchRequest: NSFetchRequest<Bar_Item>
        fetchRequest = Bar_Item.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "ingredient ==[cd] %@", ingredient.strIngredient1
        )
        fetchRequest.fetchLimit = 1

        do {
            //If the object is in the database, then remove it.
            if let object = try viewContext.fetch(fetchRequest).first {
 
                viewContext.delete(object)
                saveContext()
                ingredient.selected = false
            }
        } catch {
            debugPrint("Error \(error)")
        }

    }
    
    //This function will add the ingredient to the database
    private func addBarItem() {
        let barItem = Bar_Item(context: viewContext)
        barItem.ingredient = ingredient.strIngredient1
        saveContext()
        ingredient.selected = true
    }
    
    //This function will save all changes to the database.
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            debugPrint("An error occured: \(error)")
        }
    }
}

/*
struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRow()
    }
}
*/
