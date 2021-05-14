//
//  View+DropView.swift
//  Drops
//
//  Created by Stefano Bertagno on 14/05/21.
//

import Combine
import SwiftUI

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
        modifier(DropPresenterViewModifier(drop: drop,
                                           hidingAfter: seconds,
                                           alignment: alignment))
    }
}

#if DEBUG && !os(tvOS)
private struct DropPreviewView: View {
    /// An optional `Drop` binding.
    @State var drop: Drop?
    /// The current posiiton.
    @State var alignmentValue: Int = 0
    /// Autohides after a given amount of seconds.
    @State var seconds: TimeInterval = 2

    /// The vertical alignment.
    private var alignment: VerticalAlignment {
        switch alignmentValue {
        case 1: return .center
        case 2: return .bottom
        default: return .top
        }
    }

    /// The underlying view.
    var body: some View {
        VStack(spacing: 8) {
            Slider(value: $seconds, in: 2...10)
                .padding(.horizontal)
            Picker("Alignment", selection: $alignmentValue) {
                Text("Top").tag(0)
                Text("Center").tag(1)
                Text("Bottom").tag(2)
            }
            Button(action: {
                drop = .init(title: "DropView",
                             subtitle: "github.com/sbertix/DropView",
                             icon: Image(systemName: "hand.wave.fill").resizable(),
                             action: Image(systemName: "star.circle.fill").resizable())
            }) {
                Text("Present").bold()
            }
            Button(action: {
                drop = nil
            }) {
                Text("Hide").foregroundColor(.red)
            }
        }
        .drop($drop, hidingAfter: seconds, alignment: alignment)
    }
}

struct ViewDropPreview: PreviewProvider {
    static var previews: some View {
        DropPreviewView()
    }
}

#endif
