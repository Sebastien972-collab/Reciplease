//
//  RecipeRow.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 07/11/2022.
//
import SwiftUI

struct RecipeRow: View {
    var recipe : Recipe
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.5)
                .fill(.bacgroundApp)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(recipe.label)
                        .bold()
                        .lineLimit(1)
                    Text("\(recipe.ingredientLines.count) ingredients")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(recipe.time())
                        .font(.subheadline)
                        .lineLimit(1)
                }
                RoundedRectangleImageView(url: recipe.image)
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
            }
            .padding()
        }
        .padding()
        
    }
    
    private func getIngredients() -> String {
        var  ingredients = ""
        
        for (index, ingredient) in recipe.ingredientLines.enumerated() {
            if index > 0 {
                ingredients = ingredients + ", \(ingredient)"
            }
        }
        return ingredients
    }
    
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.bacgroundApp.edgesIgnoringSafeArea(.all)
            RecipeRow(recipe: Hit.defaultHits.recipe)
        }
    }
}
