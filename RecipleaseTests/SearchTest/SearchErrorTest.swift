//
//  SearchErrorTest.swift
//  RecipleaseTests
//
//  Created by Sébastien DAGUIN on 24/11/2022.
//

import XCTest
@testable import Reciplease

final class SearchErrorTest: XCTestCase {
    func testGetInvalideChar() {
        let error = SearchError.invalidCharacter
        XCTAssertEqual(error.localizedDescription, "Le charactère n'est pas pris en charge.")
    }
    func testGetInvalideTextfIELD() {
        let error = SearchError.invalidField
        XCTAssertEqual(error.localizedDescription, "Le text n'est pas valide")
    }
    func testGetIngredientFieldEmpty() {
        let error = SearchError.ingredientFieldEmpty
        XCTAssertEqual(error.localizedDescription, "Oups... Ce champ ne peut pas être vide")
    }
    func testGetNoRecipeFound() {
        let error = SearchError.noNewsFound
        XCTAssertEqual(error.localizedDescription, "Oups... Nous n'avons rien trouvé.")
    }
    func testGetUnkowError() {
        let error = SearchError.uknowError
        XCTAssertEqual(error.localizedDescription, "Une erreur inconnue est survenue")
    }
    
}
