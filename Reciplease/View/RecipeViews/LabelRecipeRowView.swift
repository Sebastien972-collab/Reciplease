//
//  LabelRecipeRowView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 07/11/2022.
//

import SwiftUI

struct LabelRecipeRowView: View {
    var recipe : Hit
    
    var body: some View {
        VStack(alignment : .leading) {
            HStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Label("2, 5K", systemImage: "hand.thumbsup")
                        .font(.title3)
                        .foregroundColor(.white)
                    Label("3 m", systemImage: "clock.arrow.circlepath")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 100, maxHeight: 60)
                .background(Color.backgroundApp)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            }
            Spacer()
//            VStack(spacing : 10) {
//                Text(recipe.recipe.label)
//                    .font(.title2)
//                    .foregroundColor(.white)
//                    .bold()
//                Text(getIngredients())
//                    .foregroundColor(.white)
//                    .lineLimit(0)
//                
//                
//            }
        }
    }
}

struct LabelRecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        LabelRecipeRowView(recipe: .defaultHits)
    }
}
