//
//  mobileApp.swift
//  mobile
//
//  Created by Andrzej Wójciak on 15/05/2025.
//

import SwiftUI

@main
struct mobileApp: App {
    init() {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
