//
//  DropView.swift
//  DropView
//
//  Created by Stefano Bertagno on 03/12/22.
//

import Foundation
import SwiftUI

/// A `struct` defining the drop
/// representation, together with its
/// accessory views.
public struct DropView<Content: View, Leading: View, Trailing: View>: View {
    /// The current screen hairline width.
    @Environment(\.pixelLength) private var pixelLength
    /// The current layout direction.
    @Environment(\.layoutDirection) private var layoutDirection

    /// The current drop view background color.
    @Environment(\.dropViewBackgroundColor) private var backgroundColor
    /// The current drop view balancing.
    @Environment(\.dropViewBalancing) private var balancing
    /// The current drop view separator color.
    @Environment(\.dropViewSeparatorColor) private var separatorColor
    /// The current drop view shadow.
    @Environment(\.dropViewShadow) private var shadow

    /// The current accessory width. Defaults to `nil`.
    @State private var accessoryWidth: CGFloat?

    /// The padding between components.
    @ScaledMetric(relativeTo: .headline) private var horizontalSpacing: CGFloat = 12
    /// The padding between content components.
    @ScaledMetric(relativeTo: .footnote) private var verticalSpacing: CGFloat = 2
    /// The padding to the background.
    @ScaledMetric private var padding: CGFloat = 12.5

    /// The drop view content.
    private let content: Content
    /// The leading accessory view.
    private let leading: Leading
    /// The trailing accesory view.
    private let trailing: Trailing

    /// The underlying view.
    public var body: some View {
        HStack(spacing: horizontalSpacing) {
            leading
                .fixedSize()
                .aspectRatio(contentMode: .fit)
                .frame(width: accessoryWidth, alignment: .leading)
                .background(GeometryReader {
                    Color.clear.preference(key: NewDropViewWidthPreferenceKey.self, value: [$0.size.width])
                })
            // `content` should be automatically
            // displayed vertically.
            VStack(spacing: verticalSpacing) {
                content.fixedSize()
            }.multilineTextAlignment(.center)
            trailing
                .fixedSize()
                .aspectRatio(contentMode: .fit)
                .frame(width: accessoryWidth, alignment: .trailing)
                .background(GeometryReader {
                    Color.clear.preference(key: NewDropViewWidthPreferenceKey.self, value: [$0.size.width])
                })
        }
        .fixedSize(horizontal: false, vertical: true)
        // Handle changes to accessory widths.
        .onPreferenceChange(NewDropViewWidthPreferenceKey.self) {
            guard case .default = balancing else { return }
            // `content` should always be
            // centered with `.default`
            // balancing, so we need to make
            // sure `leading` and `trailing` have
            // the same zie.
            accessoryWidth = $0.max()
        }
        // Compose the rest of the view.
        .padding(padding)
        .background(backgroundColor)
        .overlay(Capsule().strokeBorder(separatorColor, lineWidth: pixelLength))
        .clipShape(Capsule())
        .shadow(shadow)
    }

    /// Init.
    ///
    /// - parameters:
    ///     - content: A valid `Content` factory.
    ///     - leading: A valid `Leading` factory.
    ///     - trailing: A valid `Trailing` factory.
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.content = content()
        self.leading = leading()
        self.trailing = trailing()
    }
}

/// A `struct` defining the width of
/// a drop view accessories.
private struct NewDropViewWidthPreferenceKey: PreferenceKey {
    /// The default value. Defaults to empty.
    static var defaultValue: Set<CGFloat> = []
    /// Reduce subsequent values.
    static func reduce(value: inout Set<CGFloat>, nextValue: () -> Set<CGFloat>) {
        value.formUnion(nextValue())
    }
}

#if DEBUG
/// A `struct` defining the drop view preview context.
struct Previews_DropView_Previews: PreviewProvider { // swiftlint:disable:this type_name
    static var previews: some View {
        DropView {
            Text("DropView")
                .font(.headline)
            Text("github.com/sbertix/DropView")
                .font(.footnote)
                .foregroundColor(.secondary)
        } leading: {
            Image(systemName: "hand.wave.fill")
                .imageScale(.large)
                .font(.headline)
                .foregroundColor(.secondary)
        } trailing: {
            Image(systemName: "star.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.accentColor)
        }
        .padding(40)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Light")

        DropView {
            Text("DropView")
                .font(.headline)
            Text("github.com/sbertix/DropView")
                .font(.footnote)
                .foregroundColor(.secondary)
        } leading: {
            Image(systemName: "hand.wave.fill")
                .imageScale(.large)
                .font(.headline)
                .foregroundColor(.secondary)
        } trailing: {
            Image(systemName: "star.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.accentColor)
        }
        .dropViewBalancing(.compact)
        .preferredColorScheme(.dark)
        .padding(40)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Dark Compact")

        DropView(
            title: "DropView",
            subtitle: "github.com/sbertix/DropView"
        ) {
            Image(systemName: "hand.wave.fill")
                .imageScale(.large)
                .font(.headline)
                .foregroundColor(.secondary)
        } trailing: {
            Image(systemName: "star.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.accentColor)
        }
        .dropViewBackgroundColor(.yellow)
        .dropViewSeparatorColor(.blue)
        .dropViewShadow(color: .green, radius: 4, x: 2, y: 2)
        .environment(\.layoutDirection, .rightToLeft)
        .padding(40)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Right-to-Left Custom Colors/Shadow")
    }
}
#endif
