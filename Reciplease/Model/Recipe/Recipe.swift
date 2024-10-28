//
//  Recipe.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 21/11/2022.
//

import Foundation

struct RecipesSearch : Codable, Hashable {
    var _links : Links
    var hits : [Hit]
    
}
struct Hit : Codable, Hashable {
    var recipe : Recipe
    static let defaultHits = Hit(recipe: .preview)
}

struct Recipe : Hashable, Codable, Equatable{
    let label : String
    let image : String
    let source : String
    let url : String
    let ingredientLines : [String]
    let totalTime : Int
    func time() -> String {
        if totalTime == 0 {
            return "Unknow"
        }
        let hours = totalTime / 60
        let minute = totalTime - hours * 60
        return "\(hours)h\(minute) "
    }
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
            return
                lhs.label == rhs.label &&
                lhs.source == rhs.source
        }
    
    static let preview = Recipe(label: "Bacon Praline", image: "https://edamam-product-images.s3.amazonaws.com/web-img/8bc/8bc93c54c0fae39abfa88f4ff421fc60.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjECsaCXVzLWVhc3QtMSJHMEUCIG48rD7emWpmqTaoatKNB9qDyzP1CfwBr2DTnLNmdg6FAiEAxVEld5j%2FJXn%2BFvTkwqmkTpKTO8Us0hR%2BL3GQ8qxAvbUqzAQIJBAAGgwxODcwMTcxNTA5ODYiDAbp5%2Bu%2FkonZCkrAiiqpBJpTINmvWGWIQ%2FJbcnWWFqZ4YaeeQDlh5zczUDPByXZYbtXMiAqe%2B0i7jGkD6cevFvcwZgncAwNIeqxJX8R6XD2oCM7sKD7EQ%2B9IQ99FcuknJelE7GFdKlhqw87zxGpT1JxF3HGlVA%2BSNg25v%2Fzm4RE3Pv9DrAXcu7VgrAKpthqzYrYR%2Bb6y%2BJEF%2B0zizu5tPL5kgTrPjSjAt%2BXuFw0xjDSn1%2B583AlZWUusodrh%2FHFBFbog6%2BrrMG5BV61T2sW%2BmIfA6q8ZF2OBo3LnfCLHsdSBCHxKARykA1gIwwAoFoaXKTanJZwrn%2FKW4j7Ad2CCfA70HoD7O7P6%2Fttdk77cEVdJUVPP2rB3RZNcchY%2BGVXjT5A5Sg7Xf3Io7KQX%2F8sssmf2WyFL3HNbHG4p923CtwWvQF1oATbESfnm4AbZ9JBpvlI93ZCNIcRToavWODzhW98bNKMzS%2F7ushdKFnDVEjAJObMrsRsFjrqxjamRRMcyWocY6GND2thVy4mxuxF0zrjbO0iM4h9xGM4zZ4G1ErPL6PPrwcaup2fehRMOGxu40LIvN%2F6ZBsjI5txyrFVQo0NyIQcGxw3hgbUQMdfnvBAvMGI0RMzDRTdgeppXKMC3SFyWcaRSSf137J2jBWVMo4hgbsRruxKn0NQ4NFGdi1xsXPaWncUY%2F8%2F8RW57WfqKkSbQm2FrRnwTfhpK5SM8cQWMEZE%2B78tXXremIcgj7iEYFd%2FjEnKQtZ8wzd6hmwY6qQFSL%2BCAPQD%2BTkNP%2FzWqaBJ1pEjaZdXWpVwARc2yZ0s0PU4nN%2FL8SZYdEKUlE21lDzMwNhyP%2FkdGA%2BrOaTmgam%2FUDYDImR2GOPXwuDV4AdPN85l4qYOPS04kHuRIuSH7moMT3Q4oWq8GtgSXsbh16w4tZWaAtLyAhJ2PF4p8UmMKZpzzxEZHu0DCCWAGcdb%2Fgwmh1xWtRcEyVkolkdCaTGui%2B2LUniZzS0Ur&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20221107T040112Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFP3RPYG4Z%2F20221107%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=08327b6201c983d9800f46b6ee3c40e51e900224de8049a01388b11457308720", source: "Serious Eats", url: "http://www.edamam.com/ontologies/edamam.owl#recipe_89dcafc1de9a6402648155b7a7a59c73", ingredientLines: [
        "Low Potassium",
        "Kidney-Friendly",
        "Gluten-Free",
        "Wheat-Free",
        "Egg-Free",
        "Peanut-Free",
        "Soy-Free",
        "Fish-Free",
        "Shellfish-Free",
        "Crustacean-Free",
        "Celery-Free",
        "Mustard-Free",
        "Sesame-Free",
        "Lupine-Free",
        "Mollusk-Free",
        "Alcohol-Free"
    ], totalTime: 120)
    
    
}


struct Links: Hashable, Codable, Equatable {
    var next: Next
    
}
struct Next: Hashable, Codable, Equatable {
    var href: String
    var title: String
    
    
}
