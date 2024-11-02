//
//  RoundedRectangleImageView.swift
//  Reciplease
//
//  Created by Sebby on 28/10/2024.
//

import SwiftUI

struct RoundedRectangleImageView: View {
    let url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .cornerRadius(25)// Displays the loaded image.
            } else if phase.error != nil {
                Image("fruits")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .cornerRadius(25)// Indicates an error.
            } else {
                ProgressView()
                    .progressViewStyle(.circular)// Acts as a placeholder.
            }
        }
    }
}

#Preview {
    RoundedRectangleImageView(url: Recipe.preview.image)
}
