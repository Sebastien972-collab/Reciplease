//
//  RecipesService.swift
//  Reciplease
//
//  Created by Sébastien Daguin on 13/04/2022.
//

import Foundation
import Alamofire


class RecipleaseService {
    static var shared = RecipleaseService()
    private init(){}
    private var recipeSession = RecipeSession()
    private var _links: Links?
    
    init(recipeSession: RecipeSession) {
        self.recipeSession = recipeSession
    }
    
    func getRecepleases(ingredients : [String], callback: @escaping (Bool, [Hit]?, Error?) -> Void)  {
        let ingredientsForUrl = Utils.clearForUrl(ingredients)
        let baseUrl = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=\(ingredientsForUrl)&app_id=1f5b21c8&app_key=663f1a5a754bd316789a05c2ff662c60")!
        launchSession(baseUrl: baseUrl) { success, hit, error in
            callback(success, hit, error)
        }
        
            }
    func getNextReciplease(callback: @escaping (Bool, [Hit]?, Error?) -> Void) {
        guard let next = _links?.next, let newUrl = URL(string: next.href) else { return callback(false, nil, nil) }
        print("Href Url: \(newUrl)")
        launchSession(baseUrl: newUrl) { success, hit, error in
            callback(success, hit, error)
        }
    }
    
    private func launchSession(baseUrl: URL, callback: @escaping (Bool, [Hit]?, Error?) -> Void) {
        recipeSession.session(url: baseUrl) { result in
            switch result {
            case .success (let data):
                do {
                    let decoder = JSONDecoder()
                    let product = try decoder.decode(RecipesSearch.self, from: data)
                    self._links = product._links
                    callback(true, product.hits, nil)
                } catch  {
                    callback(false, nil, error)
                }
            case .failure(let failure):
                callback(false, nil, failure)
            }
        }

    }
    
}
