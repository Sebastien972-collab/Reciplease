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
        NavigationStack{
            ZStack {
                Color.backgroundApp.edgesIgnoringSafeArea(.top)
                VStack {
                    VStack {
                        Text("What's in your fridge ? ")
                        SearchRecipeTextFieldView(text: $search.ingredient, action: search.addIngredients)
                        .padding()
                        Divider()
                        IngredientView(search: search)
                    }
                    .onTapGesture {
                        fieldIsFocused = false
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
                .onTapGesture {
                    fieldIsFocused = false
                }
                .toolbar(content: {
                    ToolbarItem(placement: .principal) {
                        RecipleaseTitle()
                    }
                })
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
