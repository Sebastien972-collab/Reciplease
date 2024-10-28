//
//  SearchView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 07/11/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var ingredient : String = ""
    @FocusState private var fieldIsFocused : Bool
    @StateObject private var search = Search.shared
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.backgroundApp.edgesIgnoringSafeArea(.top)
                VStack {
                    VStack {
                        Text("What's in your fridge ? ")
                        HStack {
                            TextField("Lemon, Cheese, Sausages...", text: $ingredient)
                                .accessibilityLabel(Text("Entrez vos ingredient"))
                                .focused($fieldIsFocused)
                            Button {
                                
                                search.addIngredients(ingredient)
                                
                                ingredient.removeAll()
                            } label: {
                                Text("Add")
                                    .accessibilityLabel(Text("Appuyez pour ajouter un élément"))
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                                    .background(Color("greenApp"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding()
                        Divider()
                    }
                    .frame(maxWidth : .infinity, maxHeight: 200)
                    .background(Color.white)
                    .padding(.top)
                    VStack {
                        HStack() {
                            Text("Your ingredients : ")
                                .foregroundColor(.white)
                            Spacer()
                            Button {
                                search.clearIngredients()
                            } label: {
                                Text("Clear")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                                    .background(Color.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            }
                            
                        }
                        .padding()
                        ForEach(search.ingredients, id : \.self) { ingredient in
                            Text("- \(ingredient)")
                                .font(.title3)
                                .foregroundColor(.white)
                                .bold()
                        }
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
        SearchView()
    }
}
