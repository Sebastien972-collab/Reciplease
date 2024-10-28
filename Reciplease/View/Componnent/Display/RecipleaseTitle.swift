//
//  RecipleaseTitle.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 22/11/2022.
//

import SwiftUI

struct RecipleaseTitle: View {
    var body: some View {
        Text("Reciplease")
            .font(.title)
            .foregroundColor(.white)
    }
}

struct RecipleaseTitle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bacgroundAppColor").edgesIgnoringSafeArea(.top)
            RecipleaseTitle()
        }
    }
}
