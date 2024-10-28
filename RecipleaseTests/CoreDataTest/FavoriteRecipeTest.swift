//
//  FavoriteRecipe.swift
//  RecipleaseTests
//
//  Created by Sébastien DAGUIN on 10/04/2023.
//

import XCTest
@testable import Reciplease

final class FavoriteRecipeTest: XCTestCase {
    
    var favoriteRecipe: FavoriteRecipe!
    
    
    override func setUp() {
        super.setUp()
        favoriteRecipe = FavoriteRecipe(persistenceController: PersistenceController(inMemory: true))
    }
    func test() {
        XCTAssertTrue(favoriteRecipe.all.isEmpty)
    }
    
    func testAddRecipe() {
        do {
            try favoriteRecipe.saveRecipe(recipe: .preview)
        } catch {
            XCTAssertNil(error)
        }
        XCTAssertTrue(favoriteRecipe.all.isNotEmpty)
        XCTAssertEqual(favoriteRecipe.all.count, 1 )
        XCTAssertTrue(favoriteRecipe.checkElementIsFavorite(recipe: .preview))
        
    }
    
    func testRemoveRecipe() {
        print(favoriteRecipe.all.count)
        do {
            try favoriteRecipe.saveRecipe(recipe: .preview)
            try favoriteRecipe.removeElementInFavorite(recipe: .preview)
        } catch {
            print(error.localizedDescription)
            
        }
        XCTAssertFalse(favoriteRecipe.checkElementIsFavorite(recipe: .preview))
        
        
    }
    
    func testRemoveANoExistingRecipe() {
        do {
            try favoriteRecipe.removeElementInFavorite(recipe: .preview)
        } catch  {
            XCTAssertNotNil(error)
        }
    }
    
    func testFunctionSaveRecipeWhoRemoveRecipe() {
        do {
            try favoriteRecipe.saveRecipe(recipe: .preview)
            try favoriteRecipe.saveRecipe(recipe: .preview)
        } catch {
            print(error.localizedDescription)
            
        }
        XCTAssertFalse(favoriteRecipe.checkElementIsFavorite(recipe: .preview))
    }
    
    
    func testErrorRemoveRecipe() {
        do {
            try favoriteRecipe.removeElementInFavorite(recipe: .preview)
        } catch  {
            XCTAssertNotNil(error)
        }
    }
    
    func test5() {
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<FavoriteRecipeCount>>>>>>>>>>>>>>>>>>")
        print(favoriteRecipe.all.count)
    }
    

}
