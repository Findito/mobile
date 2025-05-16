//
//  MapView.swift
//  mobile
//
//  Created by Andrzej Wójciak on 15/05/2025.
//


import SwiftUI
import CoreLocation

struct MapView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            CustomMapView()
                .edgesIgnoringSafeArea(.all)
                .searchable(text: $searchText, prompt: "Search places")
                .onChange(of: searchText) { oldValue, newValue in
                    // TODO: Focus on searched 
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
