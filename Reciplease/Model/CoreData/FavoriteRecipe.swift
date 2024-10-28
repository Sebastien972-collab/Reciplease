//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 23/11/2022.
//

import Foundation
import CoreData

class FavoriteRecipe {
    
    static let shared = FavoriteRecipe(persistenceController: PersistenceController.shared)
    
    let viewContext: NSManagedObjectContext
    
    init(persistenceController: PersistenceController) {
        self.viewContext = persistenceController.container.viewContext
    }
    private var cdRecipes : [CDRecipe] {
        let request : NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "label" , ascending: true),
            NSSortDescriptor(key: "source", ascending: true)
        ]
        guard let favoriteCDRecipes = try? viewContext.fetch(request) else {
            return []
        }
        return favoriteCDRecipes
    }
    var all : [Recipe] {
        var favoriteRecipes : [Recipe] = []
        for recipe in cdRecipes {
            let newRecipe = Recipe(label: recipe.label!, image: recipe.image!, source: recipe.source!, url: recipe.url!, ingredientLines: recipe.ingredientLines!.splitString(with: ","), totalTime: 120)
            favoriteRecipes.append(newRecipe)
        }
        return favoriteRecipes
    }
    
    func checkElementIsFavorite(recipe newRecipe : Recipe) -> Bool {
        for recipe in all {
            if  recipe == newRecipe{
                return true
            }
        }
        return false
    }
    ///This function remove a existing recipe
     func removeElementInFavorite(recipe recipeToRemove : Recipe) throws {
        for (index ,recipe) in all.enumerated() {
            if recipe == recipeToRemove {
                viewContext.delete(cdRecipes[index])
                do {
                    try viewContext.save()
                }
                catch {
                    throw error
                }
            }
        }
    }
    
    private func addNewRecipeFavorite(recipe : Recipe) throws {
        let recipeFav = CDRecipe(context: viewContext)
        recipeFav.url = recipe.url
        recipeFav.source = recipe.source
        recipeFav.image = recipe.image
        recipeFav.label = recipe.label
        var ingredientsString = ""
        for (index, ingredient) in recipe.ingredientLines.enumerated() {
            if index == 0 {
                ingredientsString += ingredient
            }
            ingredientsString += ",\(ingredient) "
        }
        recipeFav.ingredientLines = ingredientsString
        
        do {
            try viewContext.save()
        } catch {
            throw error
        }
    }
    /// This function save or unsave a  recipe
    func saveRecipe(recipe : Recipe) throws {
        switch checkElementIsFavorite(recipe: recipe) {
        case true :
            do {
                try removeElementInFavorite(recipe: recipe)
                
            } catch {
                throw error
            }
            
        case false :
            do {
                try addNewRecipeFavorite(recipe: recipe)
                
            } catch {
                throw error
            }
        }
    }
}
