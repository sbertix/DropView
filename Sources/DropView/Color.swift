//
//  SwiftUI.swift
//  DropView
//
//  Created by Stefano Bertagno on 14/05/21.
//

import SwiftUI

extension Color {
    /// The light drop background.
    private static let lightDropBackground: Color = .init(red: 242/255, green: 242/255, blue: 247/255)
    /// The dark drop background.
    private static let darkDropBackground: Color = .init(red: 28/255, green: 28/255, blue: 30/255)

    /// The drop background color.
    ///
    /// - parameter scheme: A valid `ColorScheme`.
    /// - returns: A valid `Color`.
    static func dropBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? darkDropBackground : lightDropBackground
    }

    /// The light drop separator.
    private static let lightDropSeparator: Color = .init(red: 234/255, green: 234/255, blue: 237/255)
    /// The dark drop separator.
    private static let darkDropSeparator: Color = .init(red: 39/255, green: 39/255, blue: 41/255)

    /// The separator color.
    ///
    /// - parameter scheme: A valid `ColorScheme`.
    /// - returns: A valid `Color`.
    static func dropSeparator(for scheme: ColorScheme) -> Color {
        scheme == .dark ? darkDropSeparator : lightDropSeparator
    }
}
