//
//  RecipesList.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 07/11/2022.
//

import SwiftUI

struct RecipesListView: View {
    @ObservedObject var search: SearchManager
    @State private var scale = 1.0
    var body: some View {
        ZStack {
            Color.backgroundApp.edgesIgnoringSafeArea(.top)
            ScrollView {
                VStack {
                    ForEach(search.recipes, id: \.self) { recipe in
                        NavigationLink {
                            RecipeDetailsView(recipe: recipe)
                        } label: {
                            RecipeRow(recipe: recipe)
                        }
                        
                    }
                    ContinueButtonView(title: "Rectettes suivantes", action: search.getNextPage)
                    
                    .padding()
                }
            }
        }
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(search: SearchManager.previews)
        }
    }
}
