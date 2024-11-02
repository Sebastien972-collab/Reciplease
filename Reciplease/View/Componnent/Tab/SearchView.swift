//
//  SearchView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 07/11/2022.
//

import SwiftUI

struct SearchView: View {
    @FocusState private var fieldIsFocused : Bool
    @StateObject var search = SearchManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundApp.edgesIgnoringSafeArea(.top)
                VStack {
                    VStack {
                        SearchRecipeTextFieldView(isFocused: _fieldIsFocused, text: $search.ingredient, action: search.addIngredients)
                        .padding()
                        IngredientView(search: search)
                            .frame(maxHeight: 400)
                        if !fieldIsFocused && search.recipes.isNotEmpty {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                RecommendationView(recipes: search.recipes)
                                    .frame(height: 250)
                            }
                                
                        }
                            
                    }
                    Spacer()
                    ZStack {
                        if search.inProgress {
                            ProgressView()
                        } else {
                            ContinueButtonView(title: "Search for recipe", action: search.getRecipes)
                                .padding()
                            
                        }
                    }
                    .navigationDestination(isPresented: $search.isComplete, destination: {
                        RecipesListView(search: search)
                    })
                    
                }
                .toolbar {
                    if fieldIsFocused {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("OK") {
                                fieldIsFocused = false
                            }
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("What's in your fridge ? ")
                    }
                }
                
            }
            .alert(isPresented: $search.showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(search.searchError.localizedDescription),
                    dismissButton: .default(Text("Ok"))
                )
            }
        }
        
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(search: .previews)
    }
}
