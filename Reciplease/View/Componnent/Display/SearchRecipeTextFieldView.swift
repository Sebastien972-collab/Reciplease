//
//  SearchRecipeTextFieldView.swift
//  Reciplease
//
//  Created by Sebby on 28/10/2024.
//

import SwiftUI

struct SearchRecipeTextFieldView: View {
    @FocusState var isFocused: Bool
    @Binding var text: String
    @Environment(\.colorScheme) private var colorScheme
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(colorScheme == .dark ? .black : .white)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Entrez vos ingredients !", text: $text)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .focused($isFocused)
                    .padding()
                Button {
                    action()
                } label: {
                    Image(systemName: "plus.circle")
                }
                
                Divider()
                Button(action: {}) {
                    Image(systemName: "slider.horizontal.3")
                }
                .disabled(true)
            }
            .padding()
        }
        .frame(maxWidth: 350, maxHeight: 60)
        .clipShape(RoundedRectangle(cornerRadius: 90))
        
    }
}


#Preview {
    ZStack {
        Color.backgroundApp.edgesIgnoringSafeArea(.all)
        SearchRecipeTextFieldView(text: .constant("")) {
            print("tapped")
        }
    }
}
