//
//  DropView+Init.swift
//  DropView
//
//  Created by Stefano Bertagno on 03/12/22.
//

import Foundation
import SwiftUI

public extension DropView {
    // MARK: Empty factories

    /// Init.
    ///
    /// - parameters:
    ///     - content: A valid `Content` factory.
    ///     - trailing: A valid `Trailing` factory.
    init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder trailing: () -> Trailing
    ) where Leading == EmptyView {
        self.init(
            content: content,
            leading: { EmptyView() },
            trailing: trailing
        )
    }

    /// Init.
    ///
    /// - parameters:
    ///     - content: A valid `Content` factory.
    ///     - leading: A valid `Leading` factory.
    init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder leading: () -> Leading
    ) where Trailing == EmptyView {
        self.init(
            content: content,
            leading: leading,
            trailing: { EmptyView() }
        )
    }

    /// Init.
    ///
    /// - parameter content: A valid `Content` factory.
    init(@ViewBuilder content: () -> Content) where Leading == EmptyView, Trailing == EmptyView {
        self.init(
            content: content,
            leading: { EmptyView() },
            trailing: { EmptyView() }
        )
    }

    // MARK: Title + subtitle

    /// Init.
    ///
    /// - parameters:
    ///     - title: A valid `String`.
    ///     - subtitle: An optional `String`. Defaults to `nil`.
    ///     - leading: A valid `Leading` factory.
    ///     - trailing: A valid `Trailing` factory.
    init(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) where Content == TupleView<(Text, Text?)> {
        self.init(
            content: {
                Text(title).font(.headline).foregroundColor(.primary)
                if let subtitle { Text(subtitle).font(.footnote).foregroundColor(.secondary) }
            },
            leading: leading,
            trailing: trailing
        )
    }

    /// Init.
    ///
    /// - parameters:
    ///     - title: A valid `String`.
    ///     - subtitle: An optional `String`. Defaults to `nil`.
    ///     - trailing: A valid `Trailing` factory.
    init(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) where Content == TupleView<(Text, Text?)>, Leading == EmptyView {
        self.init(
            title: title,
            subtitle: subtitle,
            leading: { EmptyView() },
            trailing: trailing
        )
    }

    /// Init.
    ///
    /// - parameters:
    ///     - title: A valid `String`.
    ///     - subtitle: An optional `String`. Defaults to `nil`.
    ///     - leading: A valid `Leading` factory.
    init(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder leading: () -> Leading
    ) where Content == TupleView<(Text, Text?)>, Trailing == EmptyView {
        self.init(
            title: title,
            subtitle: subtitle,
            leading: leading,
            trailing: { EmptyView() }
        )
    }

    /// Init.
    ///
    /// - parameters:
    ///     - title: A valid `String`.
    ///     - subtitle: An optional `String`. Defaults to `nil`.
    init(
        title: String,
        subtitle: String? = nil
    ) where Content == TupleView<(Text, Text?)>, Leading == EmptyView, Trailing == EmptyView {
        self.init(
            title: title,
            subtitle: subtitle,
            leading: { EmptyView() },
            trailing: { EmptyView() }
        )
    }
}
