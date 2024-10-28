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
            AsyncImage(url: URL(string: recipe.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .accessibilityHidden(true)
            
            VStack {
                HStack {
                    Spacer()
                    RecipeIndicationsLabeView(time: "\(recipe.time())")
                        .padding()
                }
                Spacer()
                Text(recipe.label)
                    .accessibilityLabel(Text("Nom de recette \(recipe.label)"))
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                
            }
            
            

        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .overlay(RoundedRectangle(cornerRadius: 25)
            .stroke(Color.white, lineWidth: 2)
        )
        .padding(.horizontal)
        
        
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
        RecipeRow(recipe: Hit.defaultHits.recipe)
    }
}
