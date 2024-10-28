//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 24/11/2022.
//

import Foundation
import Alamofire

class RecipeSession {
    func session(url: URLConvertible, callback: @escaping ( Result<Data, AFError>) -> Void) {
        AF.request(url).responseData { data in
            callback(data.result)
        }
        
    }
}
