//
//  View+DropView.swift
//  Drops
//
//  Created by Stefano Bertagno on 14/05/21.
//

import Combine
import SwiftUI

#if DEBUG && os(iOS)
private struct DropPreviewView: View {
    /// The current color scheme.
    @Environment(\.colorScheme) var colorScheme

    /// An optional `Drop` binding.
    @State var drop: Drop?
    /// The current posiiton.
    @State var alignmentValue: Int = 0
    /// Autohides after a given amount of seconds.
    @State var seconds: TimeInterval = 2

    /// The vertical alignment.
    private var alignment: VerticalAlignment {
        switch alignmentValue {
        case 1:
            return .center
        case 2:
            return .bottom
        default:
            return .top
        }
    }

    /// Compose the current drop.
    private var newDrop: Drop {
        .init(title: "DropView",
              subtitle: "github.com/sbertix/DropView",
              icon: Image(systemName: "hand.wave.fill").resizable(),
              action: Image(systemName: "star.circle.fill").resizable())
    }

    /// The underlying view.
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Seconds until autohides")) {
                    VStack {
                        Slider(value: $seconds, in: 2...10)
                        HStack {
                            Text("2")
                            Spacer()
                            Text("10")
                        }
                        .font(Font.subheadline.monospacedDigit())
                    }
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
                }
                Section(header: Text("Alignment")) {
                    Picker("Alignment", selection: $alignmentValue) {
                        Text("Top").tag(0)
                        Text("Center").tag(1)
                        Text("Bottom").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 8)
                }
                // Present or hide some drop.
                HStack {
                    HStack(spacing: 0) {
                        Text("Present")
                            .font(Font.headline)
                            .foregroundColor(.blue)
                            .padding(24)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture { self.drop = newDrop }
                        Divider()
                        Text("Dismiss")
                            .font(Font.headline)
                            .foregroundColor(.red)
                            .padding(24)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture { self.drop = nil }
                    }
                }
                .listRowInsets(.init())
            }
            .navigationBarTitle("Setup")
        }
        .drop($drop, hidingAfter: seconds, alignment: alignment)
    }
}
#endif

public extension View {
    /// Present a valid `Drop`.
    ///
    /// - parameters:
    ///     - drop: An optional `Drop` binding.
    ///     - seconds: A valid `TimeInterval`. Defaults to `2`.
    ///     - alignment: A valid `VerticalAlignment`. Defaults to `.top`.
    /// - returns: Some `View`.
    func drop(_ drop: Binding<Drop?>,
              hidingAfter seconds: TimeInterval = 2,
              alignment: VerticalAlignment = .top) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(DropPresenterView(drop: drop, alignment: alignment, seconds: seconds)
                        .id(drop.wrappedValue?.id)
                        .animation(.spring()))
    }
}

#if DEBUG && os(iOS)
internal struct ViewDropPreview: PreviewProvider {
    static var previews: some View {
        DropPreviewView()
    }
}
#endif
