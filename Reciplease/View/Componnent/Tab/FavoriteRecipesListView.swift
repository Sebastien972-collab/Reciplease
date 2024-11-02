//
//  FavoriteRecipesListView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 21/11/2022.
//

import SwiftUI

struct FavoriteRecipesListView: View {
    @State private var detailsViewIsPresented = false
    @State private var favoriteRecipes : [Recipe] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundApp.edgesIgnoringSafeArea(.top)
                ZStack {
                    Color.backgroundApp.edgesIgnoringSafeArea(.top)
                    ScrollView {
                        VStack {
                            ForEach(favoriteRecipes, id: \.self) { recipe in
                                NavigationLink {
                                    RecipeDetailsView(recipe: recipe)
                                } label: {
                                    RecipeRow(recipe: recipe)
                                }
                                
                            }
                            
                        }
                    }
                    
                }
                .navigationTitle(Text("Recettes préférées"))
            }
            .onAppear() {
                favoriteRecipes = FavoriteRecipe.shared.all
            }
        }
    }
}

struct FavoriteRecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRecipesListView()
    }
}
