//
//  BackgroundColor.swift
//  DropView
//
//  Created by Stefano Bertagno on 03/12/22.
//

import Foundation
import SwiftUI

/// A `struct` defining a custom environment
/// key used to handle background colors in
/// drop views.
private struct BackgroundColorEnvironmentKey: EnvironmentKey {
    /// The default value.
    static let defaultValue: Color = {
        #if canImport(UIKit) && !os(watchOS) && !os(tvOS)
        return .init(.secondarySystemBackground)
        #elseif canImport(UIKit)
        return .init(UIColor {
            switch $0.userInterfaceStyle {
            case .dark:
                return .init(red: 28 / 255, green: 28 / 255, blue: 30 / 255, alpha: 1)
            case .light,
                 .unspecified:
                return .init(red: 242 / 255, green: 242 / 255, blue: 247 / 255, alpha: 1)
            @unknown default:
                return .init(red: 242 / 255, green: 242 / 255, blue: 247 / 255, alpha: 1)
            }
        })
        #elseif canImport(AppKit)
        return .init(.controlBackgroundColor)
        #else
        // This should (theoretically) never be called.
        return .init(red: 242 / 255, green: 242 / 255, blue: 247 / 255)
        #endif
    }()
}

public extension EnvironmentValues {
    /// Enforce a custom drop view background color style.
    var dropViewBackgroundColor: Color {
        get { self[BackgroundColorEnvironmentKey.self] }
        set { self[BackgroundColorEnvironmentKey.self] = newValue }
    }
}

public extension View {
    /// Update the drop view background color style.
    ///
    /// - parameter backgroundColor: A valid `Color`.
    /// - returns: Some `View`.
    func dropViewBackgroundColor(_ backgroundColor: Color) -> some View {
        environment(\.dropViewBackgroundColor, backgroundColor)
    }
}
