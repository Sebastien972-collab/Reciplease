//
//  IngredientView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 23/11/2022.
//

import SwiftUI

struct IngredientView: View {
    @ObservedObject var search: SearchManager
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Liste des ingrédients:")
                Spacer()
                Button {
                    search.ingredients.removeAll()
                } label: {
                    Text("Effacer")
                }
                
            }
            ZStack {
                Rectangle()
                    .fill(Color.white)
                VStack(alignment: .leading) {
                    List(search.ingredients, id: \.self) { elem in
                        HStack {
                            Text(elem.description)
                            Spacer()
                            Button {
                                withAnimation(.easeInOut(duration: 1)) {
                                    search.removeIngredient(ingredient: elem)
                                }
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .foregroundStyle(.red)
                            }

                        }
                    }
                    .listStyle(.plain)
                }
                .multilineTextAlignment(.leading)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .padding()
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bacgroundAppColor").edgesIgnoringSafeArea(.all)
            IngredientView(search: .previews)
        }
    }
}
