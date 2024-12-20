//
//  Search.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 23/11/2022.
//

import Foundation
import SJDKitToolBox

class SearchManager: ObservableObject {
    static var shared = SearchManager()
    private init(){}
    @Published var ingredient : String = ""
    @Published var ingredients : [String] = []
    @Published var recipes : [Recipe] = []
    @Published var searchError: Error = SearchError.noNewsFound
    @Published var showError : Bool = false
    @Published var inProgress : Bool = false
    @Published var isComplete : Bool = false
    @Published var nextRecipe : Bool = false
    private var service = RecipleaseService.shared
    init(service: RecipleaseService) {
        self.service = service
    }
    
    /// Function that allows you to add ingredients
    func addIngredients()  {
        guard ingredient.isNotEmpty else {
            searchError =  SearchError.ingredientFieldEmpty
            showError.toggle()
            return
        }
        guard !ingredient.containsAnumber else {
            searchError =  SearchError.invalidCharacter
            showError.toggle()
            return
        }
        
        let newIngredients = ingredient.splitString(with: ",")
        for newIngredient in newIngredients {
            if !self.ingredients.contains(newIngredient) {
                
                self.ingredients.append(newIngredient)
            }
        }
        ingredient.removeAll()
    }
    /// Function that allows you to erase existing ingredients
    func clearIngredients() {
        ingredients.removeAll()
    }
    /// Transform hit to recipe
    private func hitsToRecipe(_ hits : [Hit]) -> [Recipe] {
        var recipesFind : [Recipe] = []
        for recipe in hits {
            recipesFind.append(recipe.recipe)
        }
        return recipesFind
    }
    /// Launch recipe search
    func getRecipes() {
        guard ingredients.isNotEmpty else {
            searchError = SearchError.ingredientFieldEmpty
            showError.toggle()
            return
        }
        inProgress.toggle()
        nextRecipe = false
        service.getRecepleases(ingredients: ingredients, callback: handle)
    }
    
    
    func getNextPage() {
        inProgress.toggle()
        nextRecipe = true
        service.getNextReciplease(callback: handle)
    }
    func removeIngredient(ingredient: String)  {
        for (index, ingredient) in ingredients.enumerated() {
            if ingredient == ingredient {
                ingredients.remove(at: index)
            }
        }
    }
    
    private func handle(success: Bool, hits: [Hit]?, error: Error?) {
        guard success, let hits = hits, error == nil else {
            self.searchError = error ?? SearchError.uknowError
            self.showError.toggle()
            return
        }
        let newRecipes = self.hitsToRecipe(hits)
        if nextRecipe {
            for newRecipe in newRecipes {
                self.recipes.append(newRecipe)
            }
        } else {
            self.recipes = newRecipes
        }
        guard self.recipes.isNotEmpty else {
            self.searchError = SearchError.noNewsFound
            self.showError.toggle()
            return
        }
        print(self.recipes.count)
        if !nextRecipe {
            self.isComplete.toggle()
        }
        self.inProgress.toggle()
    }
    
    static var previews: SearchManager {
        let manager = SearchManager()
        manager.ingredient = "Bacon, Eggs, Cheese"
        manager.addIngredients()
        manager.recipes = [.preview, .preview, .preview]
        return manager
    }
}
