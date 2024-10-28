//
//  Utils.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 23/11/2022.
//

import Foundation

struct Utils {
   
    static func clearForUrl(_ ingredients : [String]) -> String {
        var text = ""
        for ingredient in ingredients {
            let ingredientToUrl = ingredient.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            text +=  ingredientToUrl
            
        }
        print(text.utf8)
        return text
    }
    
}
