//
//  Drop.swift
//  DropView
//
//  Created by Stefano Bertagno on 14/05/21.
//

import SwiftUI

/// A `struct` defining the drop configuration.
public struct Drop: Identifiable {
    /// The underlying identifier.
    public let id: String
    /// The title.
    public let title: String
    /// The subtitle.
    public let subtitle: String?
    /// The optional "icon".
    public let icon: AnyView
    /// The optional "action".
    public let action: AnyView

    /// Whether it has a valid icon or not.
    let hasIcon: Bool
    /// Whehter it has a valid action or not.
    let hasAction: Bool

    /// Init.
    ///
    /// - parameters:
    ///     - id: A valid `String`. Defaults to a randomly generate UUID.
    ///     - title: A valid `String`.
    ///     - subtitle: An optional `String`. Defaults to `nil`.
    ///     - icon: A valid `Icon`.
    ///     - action: A valid `Action`.
    public init<Icon: View, Action: View>(id: String = UUID().uuidString,
                                          title: String,
                                          subtitle: String? = nil,
                                          icon: Icon,
                                          action: Action) {
        self.id = id
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.subtitle = subtitle?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.icon = AnyView(icon.frame(width: 25, height: 25).fixedSize().foregroundColor(.secondary))
        self.action = AnyView(action.frame(width: 35, height: 35).fixedSize().foregroundColor(.accentColor))
        self.hasIcon = !(icon is EmptyView)
        self.hasAction = !(action is EmptyView)
    }

    /// Init.
    ///
    /// - parameters:
    ///     - id: A valid `String`. Defaults to a randomly generate UUID.
    ///     - title: A valid `String`.
    ///     - subtitle: An optional `String`. Defaults to `nil`.
    ///     - icon: A valid `Icon`.
    public init<Icon: View>(id: String = UUID().uuidString,
                            title: String,
                            subtitle: String? = nil,
                            icon: Icon) {
        self.init(id: id,
                  title: title,
                  subtitle: subtitle,
                  icon: icon,
                  action: EmptyView())
    }

    /// Init.
    ///
    /// - parameters:
    ///     - id: A valid `String`. Defaults to a randomly generate UUID.
    ///     - title: A valid `String`.
    ///     - subtitle: An optional `String`. Defaults to `nil`.
    ///     - action: A valid `Action`.
    public init<Action: View>(id: String = UUID().uuidString,
                              title: String,
                              subtitle: String? = nil,
                              action: Action) {
        self.init(id: id,
                  title: title,
                  subtitle: subtitle,
                  icon: EmptyView(),
                  action: action)
    }

    /// Init.
    ///
    /// - parameters:
    ///     - id: A valid `String`. Defaults to a randomly generate UUID.
    ///     - title: A valid `String`.
    ///     - subtitle: An optional `String`. Defaults to `nil`.
    public init(id: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil) {
        self.init(id: id,
                  title: title,
                  subtitle: subtitle,
                  icon: EmptyView(),
                  action: EmptyView())
    }
}

extension Drop: Equatable {
    /// Check equality between two `Drop`s.
    ///
    /// - note: `Drop` are considered equal when their underlying `id` is the same.
    /// - returns: A valid `Bool`.
    public static func == (lhs: Drop, rhs: Drop) -> Bool {
        lhs.id == rhs.id
    }
}
