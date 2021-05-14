//
//  DropPresenterViewModifier.swift
//  DropView
//
//  Created by Stefano Bertagno on 14/05/21.
//

import Combine
import SwiftUI

/// A `struct` defining the presenter view modifier.
struct DropPresenterViewModifier: ViewModifier {
    /// An optional `Drop` binding.
    @Binding var drop: Drop?
    /// Seconds until hiding.
    let seconds: TimeInterval
    /// The current postiion.
    let alignment: VerticalAlignment

    /// The current transition.
    private var transition: AnyTransition {
        switch alignment {
        case .top:
            return AnyTransition.offset(x: 0, y: -200).combined(with: .opacity)
        case .bottom:
            return AnyTransition.offset(x: 0, y: 200).combined(with: .opacity)
        default:
            return AnyTransition.scale.combined(with: .opacity)
        }
    }

    /// Init.
    ///
    /// - parameters:
    ///     - drop: An optional `Drop` binding.
    ///     - seconds: A valid `TimeInterval`.
    ///     - alignment: A valid `VerticalAlignment`.
    init(drop: Binding<Drop?>,
         hidingAfter seconds: TimeInterval,
         alignment: VerticalAlignment) {
        self._drop = drop
        self.seconds = seconds
        self.alignment = alignment
    }

    /// Update content.
    ///
    /// - parameter content: Some `Content`.
    /// - returns: Some `View`.
    func body(content: Content) -> some View {
        content.frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(DropPresenterView(drop: drop, alignment: alignment)
                        .transition(transition)
                        .id(drop?.id)
                        .animation(.spring()))
            .onReceive(Just(drop?.id)
                        .compactMap { $0 }
                        .delay(for: .seconds(seconds), scheduler: RunLoop.main)
                        .filter { $0 == drop?.id }
                        .receive(on: RunLoop.main)) { _ in
                drop = nil
            }
    }
}
