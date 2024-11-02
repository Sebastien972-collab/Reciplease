//
//  RecipeDetails.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 07/11/2022.
//

import SwiftUI
import CoreData
import Translation
struct RecipeDetailsView: View {
    @State var recipe : Recipe
    @State private var translation: String = ""
    @State private var configuration: TranslationSession.Configuration?
    @State private var selectedTranslation: [String] = []
    let favoriteRecipe = FavoriteRecipe.shared
    @State private var showDirectionView = false
    @State private var error : Error?
    @State private var alertIsPresented = false
    @State private var isFavorite = false
    @State private var showTranslation = false
    var body: some View {
        ZStack {
            Color.backgroundApp.edgesIgnoringSafeArea(.top)
            VStack(alignment: .center, content: {
                RoundedRectangleImageView(url: recipe.image)
                VStack(alignment: .leading, spacing: 10) {
                    Text("DESCRIPTION DE LA RECETTE")
                        .font(.headline)
                        .foregroundStyle(.greenApp)
                    Text(recipe.label)
                        .font(.title2)
                        .bold()
                    HStack {
                        Text("Ingredients: ")
                        Spacer()
                        Button {
                            selectedTranslation = recipe.ingredientLines
                            showTranslation.toggle()
                        } label: {
                            HStack {
                                Text("Traduire")
                                Text("(Bêta)")
                                    .foregroundStyle(.gray)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    List(recipe.ingredientLines, id: \.self){ ingredient in
                        HStack {
                            Text(ingredient)
                            Spacer()
                            Button {
                                translation = ingredient
                                showTranslation.toggle()
                            } label: {
                                Text("Traduire")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                Spacer()
                ContinueButtonView(title: "Voir les instructions") {
                    showDirectionView.toggle()
                }
                .navigationDestination(isPresented: $showDirectionView) {
                    SafariView(url: recipe.url)
                }
            })
            .translationPresentation(isPresented: $showTranslation, text: translation)
            .translationTask(configuration, action: { session in
                do {
                    let response = try await session.translate(recipe.label)
                    recipe.label = response.targetText
                } catch  {
                    self.error = error
                    alertIsPresented.toggle()
                }
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Détails de la recette")
                }
                ToolbarItem(placement : .topBarTrailing) {
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
                            .foregroundColor(isFavorite ? .yellow : .gray)
                    }
                    
                }
            }
            .onAppear() {
                isFavorite = favoriteRecipe.checkElementIsFavorite(recipe: recipe)
            }
        }
        .padding()
        .alert(isPresented: $alertIsPresented) {
            Alert(title: Text("Erreur"), message: Text(error?.localizedDescription ?? "Unknow error"), dismissButton: .default(Text("Ok")))
        }
    }
    
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecipeDetailsView(recipe: Hit.defaultHits.recipe)
        }
    }
}
