//
//  ContentView.swift
//  mobile
//
//  Created by Andrzej Wójciak on 15/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }.tabBarBackground(color: UIColor.systemGray6)
        Button("Report Found Item") {
            // Call the async function within a Task
            Task {
                do {
                    // Instantiate Findito (if it's just a container for the method)
                    let finditoClientLogic = Findito()
                    try await finditoClientLogic.runClient()
                    print("GRPC call completed.")
                } catch {
                    print("GRPC call failed: \(error)")
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
