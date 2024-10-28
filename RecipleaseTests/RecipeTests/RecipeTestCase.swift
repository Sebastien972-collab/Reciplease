//
//  RecipeTestCase.swift
//  RecipleaseTests
//
//  Created by Sébastien DAGUIN on 25/11/2022.
//

import XCTest
import Alamofire
@testable import Reciplease

final class RecipeTestCase: XCTestCase {
    
    func testGetAcorrectResponse() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.recipeCorrectData) )
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        recipeService.getRecepleases(ingredients: []) { success, hits, error in
            XCTAssertTrue(success)
            XCTAssertNotNil(hits)
            XCTAssertNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.1)
    }
    func testGetAIncorrectResponse() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.failure(FakeResponseData.reponseError))
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        recipeService.getRecepleases(ingredients: []) { success, hits, error in
            XCTAssertFalse(success)
            XCTAssertNil(hits)
            
            XCTAssertNotNil(error)
        }
    }
    func testGetASuccessRequestButAIncorrectDataResponse() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.incorrectData))
        let recipeService = RecipleaseService(recipeSession: recipeSession)
        recipeService.getRecepleases(ingredients: []) { success, hits, error in
            XCTAssertFalse(success)
            XCTAssertNil(hits)
            XCTAssertNotNil(error)
        }
    }
    
    
    
    func testGetNextRecipeWithCorrectDataResponse() {
        let recipeSession = RecipeSessionFake(fakeResponse: Result.success(FakeResponseData.recipeCorrectData) )
        let recipeService = RecipleaseService(recipeSession: recipeSession)
//        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        recipeService.getRecepleases(ingredients: []) { success, hit, error in
        }
        recipeService.getNextReciplease { success, hit, error in
            XCTAssertTrue(success)
            XCTAssertNotNil(hit)
            XCTAssertNil(error)
        }
    }
}
