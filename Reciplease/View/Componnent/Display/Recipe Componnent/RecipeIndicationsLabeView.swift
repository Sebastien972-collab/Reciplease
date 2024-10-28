//
//  RecipeIndicationsLabeView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 28/11/2022.
//

import SwiftUI

struct RecipeIndicationsLabeView: View {
    
    let time : String
    
    var body: some View {
        VStack(alignment : .leading, spacing: 8) {
            Label("", systemImage: "hand.thumbsup.fill")
            Label(time , systemImage: "timer.circle.fill")
        }
        .accessibilityLabel(Text("Temps de cuisson \(time)"))
        .foregroundColor(.white)
        .padding()
        .background(Color("bacgroundAppColor"))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
        
    }
}

struct RecipeIndicationsLabeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeIndicationsLabeView(time: "1H30")
    }
}
