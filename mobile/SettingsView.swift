//
//  SettingsView.swift
//  mobile
//
//  Created by Andrzej Wójciak on 15/05/2025.
//


import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Option 1", isOn: .constant(true))
                    Toggle("Option 2", isOn: .constant(false))
                }
            }
            .navigationTitle("Settings")
        }
    }
}
