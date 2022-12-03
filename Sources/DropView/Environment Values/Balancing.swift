//
//  Balancing.swift
//  DropView
//
//  Created by Stefano Bertagno on 03/12/22.
//

import Foundation
import SwiftUI

/// An `enum` listing available content
/// balancing inside of a drop view.
public enum Balancing {
    /// `content` is always centered in the
    /// overall drop view, by insuring `leading`
    /// and `trailing` have the same relative
    /// width.
    case `default`
    
    /// `content` is not centered, and `leading`
    /// and `trailing` are not guaranteed to
    /// have the same relative width.
    case compact
}

/// A `struct` defining a custom environment
/// key used to handle balancing in drop views.
private struct BalancingEnvironmentKey: EnvironmentKey {
    /// The default value.
    static let defaultValue: Balancing = .default
}

public extension EnvironmentValues {
    /// Enforce a custom drop view `Balancing` style.
    var dropViewBalancing: Balancing {
        get { self[BalancingEnvironmentKey.self] }
        set { self[BalancingEnvironmentKey.self] = newValue }
    }
}

public extension View {
    /// Update the drop view `Balancing` style.
    ///
    /// - parameter balancing: A valid `Balancing`.
    /// - returns: Some `View`.
    func dropViewBalancing(_ balancing: Balancing) -> some View {
        environment(\.dropViewBalancing, balancing)
    }
}
