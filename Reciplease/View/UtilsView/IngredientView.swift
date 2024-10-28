//
//  IngredientView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 23/11/2022.
//

import SwiftUI

struct IngredientView: View {
    var ingredients : [String]
    
    var body: some View {
        VStack(alignment : .leading) {
            Text("Ingredients ")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.horizontal)
            ScrollView(showsIndicators: true) {
                VStack(alignment : .leading, spacing: 10) {
                    ForEach(ingredients, id: \.self) { ingredient in
                        Text("- \(ingredient)")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bacgroundAppColor").edgesIgnoringSafeArea(.all)
            IngredientView(ingredients: Recipe.preview.ingredientLines)
        }
    }
}
