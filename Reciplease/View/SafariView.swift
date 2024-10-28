//
//  SafariView.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 28/11/2022.
//

import SwiftUI
import SafariServices

struct SafariView : UIViewControllerRepresentable {
    let url : String
    typealias UIViewControllerType = SFSafariViewController
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let controller = SFSafariViewController(url: URL(string: url)!)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
