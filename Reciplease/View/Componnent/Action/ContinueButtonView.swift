//
//  ContinueButtonView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 22/11/2022.
//

import SwiftUI

struct ContinueButtonView: View {
    let title : String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .accessibilityLabel("Appuyer pour continuer")
                .foregroundColor(.white)
                .frame(width: 300, height: 60)
                .background(Color("greenApp"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
    }
}

struct ContinueButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButtonView(title: "Search for recipe") {
            
        }
    }
}
