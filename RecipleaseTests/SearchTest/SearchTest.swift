//
//  SearchTest.swift
//  RecipleaseTests
//
//  Created by Sébastien DAGUIN on 24/11/2022.
//

import XCTest
@testable import Reciplease

final class SearchTest: XCTestCase {
    
    var newSearch = Search(service: RecipleaseService(recipeSession: RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.recipeCorrectData) )))
    
    
    
    func testGetEmptyIngredients() {
        
        newSearch.addIngredients("")
        XCTAssertEqual(newSearch.searchError as! SearchError, SearchError.ingredientFieldEmpty)
        
    }
    func testGetInvalidChar() {
        newSearch.addIngredients("Souppe, Lemon, Apple, 12")
        XCTAssertEqual(newSearch.searchError as! SearchError, SearchError.invalidCharacter)
    }
    func testGetIngredientsAndClearIngredients() {
        let ingredients = ["Souppe, Lemon, Apple"]
        newSearch.ingredients = ingredients
        newSearch.clearIngredients()
        XCTAssertTrue(newSearch.ingredients.isEmpty)
    }
    func testGetValideIngredients() {
        newSearch.clearIngredients()
        print(newSearch.ingredients.count)
        newSearch.addIngredients("Souppe, Lemon, Apple")
        for ingredients in newSearch.ingredients {
            print(ingredients)
        }
        XCTAssertEqual(newSearch.ingredients.count, 3)
    }
//    func testHitToRecipe() {
//        let recipes = newSearch.hitsToRecipe([.defaultHits])
//        XCTAssertFalse(recipes.isEmpty)
//        
//    }
    
    func testGetRecipesWithEmptyIngredients() {
        newSearch.clearIngredients()
        
        newSearch.getRecipes()
        
        XCTAssertTrue(newSearch.searchError as! SearchError == SearchError.ingredientFieldEmpty)
        
    }
    
    func testGivenAcorrectDataAndCheckRecipeNotEmpty() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.recipeCorrectData) )
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        let search = Search(service: recipeService)
        
        search.addIngredients("Souppe, Lemon, Apple")
        search.getRecipes()
        print(search.recipes.count)
        XCTAssertTrue(search.recipes.isNotEmpty)
    }
    func testGivenAIncorrectDataAndCheckRecipeEmpty() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.incorrectData) )
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        let search = Search(service: recipeService)
        
        search.getRecipes()
        print(search.recipes.count)
        XCTAssertTrue(search.recipes.isEmpty)
    }
    
    func testCheckTheFirstRecipeWithCorrectData() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.recipeCorrectData) )
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        
        let search = Search(service: recipeService)
        search.addIngredients("Souppe, Lemon, Apple")
        search.getRecipes()
        print("Nombre de recipe est \(search.recipes.count)")
        let firstRecipe = search.recipes.first!
        XCTAssertTrue(firstRecipe.label == "Bacon Praline")
        
        
    }
    func testGivenIncorrectDataTestError() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.failure(FakeResponseData.reponseError) )
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        let search = Search(service: recipeService)
        
        search.addIngredients("Souppe, Lemon, Apple")
        search.getRecipes()
        print(search.recipes.count)
        XCTAssertTrue(search.recipes.isEmpty)
        XCTAssertTrue(search.showError)
        
        
    }
    
    func testNextRecipeFunction() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.recipeCorrectData) )
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        let search = Search(service: recipeService)
        
        search.addIngredients("Souppe, Lemon, Apple")
        search.getRecipes()
        search.getNextPage()
        print(search.recipes.count)
        XCTAssertTrue(search.recipes.isNotEmpty)
    }
    
    func testNextRecipeWithIncorrectData() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.incorrectData) )
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        let search = Search(service: recipeService)
        
        search.addIngredients("Souppe, Lemon, Apple")
        search.getRecipes()
        search.getNextPage()
        print(search.recipes.count)
        XCTAssertTrue(search.recipes.isEmpty)
    }
    
    //    func testGetNexRecipe() {
    //        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.recipeCorrectData) )
    //        let recipeService = RecipleaseService(recipeSession: recipeSession)
    //        newSearch.service = recipeService
    //
    //        newSearch.getRecipes()
    //        let recipesCount = newSearch.recipes.count
    //        newSearch.getNextPage()
    //
    //        XCTAssertTrue(recipesCount < newSearch.recipes.count)
    //    }
}
