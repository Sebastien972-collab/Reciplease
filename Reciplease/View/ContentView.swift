//
//  ContentView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 07/11/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    enum Selection {
        case search, favorite
    }
    @State private var selection : Selection = .search
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(Selection.search)
                FavoriteRecipesListView()
                    .tabItem {
                        Label("Favorite", systemImage: "star")
                    }
                    .tag(Selection.favorite)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
