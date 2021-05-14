//
//  DropView.swift
//  DropView
//
//  Created by Stefano Bertagno on 14/05/21.
//

import SwiftUI

/// A `struct` defining a view displaying `Drop`s.
public struct DropView: View {
    /// The color scheme.
    @Environment(\.colorScheme) var colorScheme
    /// The pixel length.
    @Environment(\.pixelLength) var pixelLength

    /// The underlying drop.
    public let drop: Drop

    /// Init.
    ///
    /// - parameter drop: A valid `Drop`.
    public init(drop: Drop) {
        self.drop = drop
    }

    /// The body.
    public var body: some View {
        HStack(spacing: 20) {
            drop.icon.layoutPriority(2)
            VStack(spacing: 0) {
                Text(drop.title)
                    .foregroundColor(.primary)
                    .font(.subheadline)
                    .bold()
                    .layoutPriority(1)
                if let subtitle = drop.subtitle {
                    Text(subtitle)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .layoutPriority(0)
                }
            }
            .lineLimit(1)
            drop.action.layoutPriority(2)
        }
        .padding(.init(top: drop.subtitle == nil ? 15 : 10,
                       leading: drop.hasIcon ? 12.5 : drop.hasAction ? 40 : 50,
                       bottom: drop.subtitle == nil ? 15 : 10,
                       trailing: drop.hasAction ? 12.5 : drop.hasIcon ? 40 : 50))
        .frame(minHeight: 50)
        .background(Color.dropBackground(for: colorScheme))
        .mask(Capsule())
        .overlay(Capsule().strokeBorder(Color.dropSeparator(for: colorScheme), lineWidth: pixelLength))
        .shadow(color: .black.opacity(0.15),
                radius: 25,
                x: 0,
                y: 0)
        .padding()
    }
}

#if DEBUG

struct DropViewPreview: PreviewProvider {
    static var previews: some View {
        DropView(drop: .init(title: "DropView",
                             subtitle: "github.com/sbertix/DropView",
                             icon: Image(systemName: "hand.wave.fill").resizable(),
                             action: Image(systemName: "star.circle.fill").resizable()))
            .previewLayout(.fixed(width: 500, height: 200))

        VStack(spacing: 8) {
            DropView(drop: .init(title: "A notification",
                                 subtitle: "This could be left empty"))
            DropView(drop: .init(title: "A notification",
                                 subtitle: "This could be left empty",
                                 action: Image(systemName: "star.circle.fill").resizable()))
                .environment(\.colorScheme, .dark)
            DropView(drop: .init(title: "A notification",
                                 subtitle: "This could be left empty",
                                 icon: Image(systemName: "hand.wave.fill").resizable()))
            DropView(drop: .init(title: "A notification",
                                 subtitle: "This could be left empty, but we're actually making it super long",
                                 icon: Image(systemName: "hand.wave.fill").resizable(),
                                 action: Image(systemName: "star.circle.fill").resizable()))
                .environment(\.colorScheme, .dark)
            DropView(drop: .init(title: "A notification"))
        }
    }
}

#endif
