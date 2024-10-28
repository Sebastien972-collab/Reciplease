//
//  RecipeDetails.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 07/11/2022.
//

import SwiftUI
import CoreData
struct RecipeDetailsView: View {
    @State var recipe : Recipe
    let favoriteRecipe = FavoriteRecipe.shared
    @State private var showDirectionView = false
    @State private var error : Error?
    @State private var alertIsPresented = false
    @State private var isFavorite = false
    
    var body: some View {
        ZStack {
            Color.backgroundApp.edgesIgnoringSafeArea(.top)
            VStack(content: {
                VStack(alignment: .leading, spacing : 10) {
                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .accessibilityHidden(true)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(recipe.label)
                        .accessibilityLabel(Text("Nom de la recette : \(recipe.label)"))
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.horizontal)
                }
                .padding(.bottom)
                IngredientView(ingredients: recipe.ingredientLines)
                ContinueButtonView(title: "Get direction") {
                    showDirectionView.toggle()
                }
                .padding()
                .fullScreenCover(isPresented: $showDirectionView) {
                    SafariView(url: recipe.url)
                }
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    RecipleaseTitle()
                }
                ToolbarItem(placement : .navigationBarTrailing) {
                    Button {
                        do {
                            try favoriteRecipe.saveRecipe(recipe: recipe)
                            isFavorite.toggle()
                        } catch {
                            self.error = error
                            alertIsPresented.toggle()
                        }
                       
                    } label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(isFavorite ? .yellow : .white)
                    }
                    
                }
            }
            .onAppear() {
                isFavorite = favoriteRecipe.checkElementIsFavorite(recipe: recipe)
            }
        }
        .alert(isPresented: $alertIsPresented) {
            Alert(title: Text("Erreur"), message: Text(error?.localizedDescription ?? "Unknow error"), dismissButton: .default(Text("Ok")))
        }
    }
    
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeDetailsView(recipe: Hit.defaultHits.recipe)
        }
    }
}
