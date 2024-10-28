//
//  ImageRecipeView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 23/11/2022.
//

import SwiftUI

struct ImageRecipeView: View {
    var url : String
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 200)
        } placeholder: {
            ProgressView()
        }
    }
}

struct ImageRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRecipeView(url: "")
    }
}
