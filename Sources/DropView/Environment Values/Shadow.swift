//
//  Shadow.swift
//  DropView
//
//  Created by Stefano Bertagno on 03/12/22.
//

import Foundation
import SwiftUI

/// A `struct` defining shadow-like
/// properties for drop views.
public struct Shadow {
    /// The shadow color. Defaults to `.black`.
    let color: Color
    /// The shadow radius.
    let radius: CGFloat
    /// The shadow x offset. Defaults to `0`.
    let x: CGFloat
    /// The shadow y offset. Defaults to `0`.
    let y: CGFloat
    
    /// Init.
    ///
    /// - parameters:
    ///     - color:  The shadow color. Defaults to `.black`.
    ///     - radius: The shadow radius.
    ///     - x: The shadow x offset. Defaults to `0`.
    ///     - y: The shadow y offset. Defaults to `0`.
    public init(
        color: Color = .black,
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

/// A `struct` defining a custom environment
/// key used to handle shadows in drop views.
private struct ShadowEnvironmentKey: EnvironmentKey {
    /// The default value.
    static let defaultValue: Shadow = .init(
        color: .black.opacity(0.15),
        radius: 18,
        x: 0,
        y: 0
    )
}

public extension EnvironmentValues {
    /// Enforce a custom drop view shadow style.
    var dropViewShadow: Shadow {
        get { self[ShadowEnvironmentKey.self] }
        set { self[ShadowEnvironmentKey.self] = newValue }
    }
}

public extension View {
    /// Update the drop view separator shadow style.
    ///
    /// - parameter shadow: A valid `Shadow`.
    /// - returns: Some `View`.
    func dropViewShadow(_ shadow: Shadow) -> some View {
        environment(\.dropViewShadow, shadow)
    }
    
    /// Update the drop view separator shadow style.
    ///
    /// - parameters:
    ///     - color:  The shadow color. Defaults to `.black`.
    ///     - radius: The shadow radius.
    ///     - x: The shadow x offset. Defaults to `0`.
    ///     - y: The shadow y offset. Defaults to `0`.
    /// - returns: Some `View`.
    func dropViewShadow(
        color: Color = .black,
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) -> some View {
        dropViewShadow(.init(color: color, radius: radius, x: x, y: y))
    }
    
    /// Apply a given `Shadow`.
    ///
    /// - parameter shadow: A valid `Shadow`.
    /// - returns: Some `View`.
    func shadow(_ shadow: Shadow) -> some View {
        self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}
