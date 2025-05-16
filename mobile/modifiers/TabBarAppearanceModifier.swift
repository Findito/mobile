//
//  TabBarAppearanceModifier.swift
//  mobile
//
//  Created by Andrzej Wójciak on 15/05/2025.
//

import SwiftUI

struct TabBarAppearanceModifier: ViewModifier {
    init(backgroundColor: UIColor, opacity: CGFloat = 0.7) {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = backgroundColor.withAlphaComponent(opacity)

        let offset = UIOffset(horizontal: 0, vertical: 0)
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = offset
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = offset

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func tabBarBackground(color: UIColor, opacity: CGFloat = 0.9, iconOffset: CGFloat = -6) -> some View {
        self.modifier(TabBarAppearanceModifier(backgroundColor: color, opacity: opacity))
    }
}
