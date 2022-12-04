//
//  SeparatorColor.swift
//  DropView
//
//  Created by Stefano Bertagno on 03/12/22.
//

import Foundation
import SwiftUI

/// A `struct` defining a custom environment
/// key used to handle separator colors in
/// drop views.
private struct SeparatorColorEnvironmentKey: EnvironmentKey {
    /// The default value.
    static let defaultValue: Color = {
        #if canImport(UIKit) && !os(watchOS) && !os(tvOS)
        return .init(.quaternarySystemFill)
        #elseif canImport(UIKit)
        return .init(UIColor {
            switch $0.userInterfaceStyle {
            case .dark:
                return .init(red: 39 / 255, green: 39 / 255, blue: 41 / 255, alpha: 1)
            case .light,
                 .unspecified:
                return .init(red: 234 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            @unknown default:
                return .init(red: 234 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            }
        })
         #elseif canImport(AppKit)
        return .init(NSColor(name: nil) {
            switch $0.bestMatch(from: [.aqua, .darkAqua]) {
            case NSAppearance.Name.darkAqua:
                return .init(red: 39 / 255, green: 39 / 255, blue: 41 / 255, alpha: 1)
            default:
                return .init(red: 234 / 255, green: 234 / 255, blue: 237 / 255, alpha: 1)
            }
        })
        #else
        // This should never be called.
        return .init(red: 234 / 255, green: 234 / 255, blue: 237 / 255)
        #endif
    }()
}

public extension EnvironmentValues {
    /// Enforce a custom drop view separator color style.
    var dropViewSeparatorColor: Color {
        get { self[SeparatorColorEnvironmentKey.self] }
        set { self[SeparatorColorEnvironmentKey.self] = newValue }
    }
}

public extension View {
    /// Update the drop view separator color style.
    ///
    /// - parameter separatorColor: A valid `Color`.
    /// - returns: Some `View`.
    func dropViewSeparatorColor(_ separatorColor: Color) -> some View {
        environment(\.dropViewSeparatorColor, separatorColor)
    }
}
