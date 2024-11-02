//
//  RecommendationView.swift
//  Reciplease
//
//  Created by Sebby on 28/10/2024.
//

import SwiftUI

struct RecommendationView: View {
    var recipes: [Recipe]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommenations: ")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(recipes, id: \.self) { recipe in
                        NavigationLink(destination: {
                            RecipeDetailsView(recipe: recipe)
                        }, label: {
                            VStack(alignment: .leading) {
                                RoundedRectangleImageView(url: recipe.image)
                                    .frame(width: 200, height: 150)
                                    .padding(.vertical)
                                Text(recipe.label)
                                    .lineLimit(1)
                                    .padding(.top, 3)
                            }
                            .frame(width: 200)
                        })
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    RecommendationView(recipes: SearchManager.previews.recipes)
}
