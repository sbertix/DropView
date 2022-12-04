//
//  ItemDropViewPresenter.swift
//  DropView
//
//  Created by Stefano Bertagno on 04/12/22.
//

import Combine
import Foundation
import SwiftUI

/// A `struct` defining a view modifier
/// tasked with overlaying the drop view.
private struct ItemDropViewPresenter<Item: Identifiable, C: View, L: View, R: View>: ViewModifier {
    /// The drag gesture translation.
    @GestureState var translation: CGFloat = 0

    /// A binding to whether it's being presented or not.
    @Binding var item: Item?
    /// The vertical alignment.
    let alignment: VerticalAlignment
    /// The auto-dismiss time interval.
    let timer: TimeInterval
    /// The drop view factory.
    let dropView: (Item) -> DropView<C, L, R>

    /// The associated transition edge.
    private var edge: Edge {
        switch alignment {
        case .center: return .leading
        case .bottom: return .bottom
        default: return .top
        }
    }

    /// Compose the view.
    ///
    /// - parameter content: Some `Content`.
    /// - returns: Some `View`.
    func body(content: Content) -> some View {
        content.overlay(
            item.flatMap { current in
                dropView(current)
                    // Adjust the position based on
                    // the user interaction.
                    .offset(
                        x: alignment == .center ? translation : 0,
                        y: alignment == .center ? 0 : translation
                    )
                    .gesture(
                        // Drag-to-dismiss.
                        DragGesture()
                            .updating($translation) { change, state, _ in
                                switch alignment {
                                case .center: state = min(change.translation.width, 0)
                                case .bottom: state = max(change.translation.height, 0)
                                default: state = min(change.translation.height, 0)
                                }
                            }
                            .onEnded { _ in
                                guard item?.id == current.id else { return }
                                item = nil
                            }
                    )
                    .onReceive(Just(current.id).delay(for: .seconds(timer), scheduler: RunLoop.main)) {
                        guard item?.id == $0 else { return }
                        item = nil
                    }
                    .transition(.move(edge: edge).combined(with: .opacity))
                    .id(current.id)
                    .animation(.easeInOut, value: alignment)
            },
            alignment: .init(horizontal: .center, vertical: alignment)
        )
        .animation(.interactiveSpring().speed(0.5), value: item?.id)
    }
}

public extension View {
    /// Overlay a drop view.
    ///
    /// - parameters:
    ///     - isPresented: An optional `Identifiable` binding.
    ///     - alignment: A valid `VerticalAlignment`. Defaults to `.top`.
    ///     - timer: The time before it gets autodismissed. Defaults to `2`.
    ///     - content: The drop view factory.
    /// - returns: Some `View`.
    @ViewBuilder func drop<I: Identifiable, C: View, L: View, T: View>(
        item: Binding<I?>,
        alignment: VerticalAlignment = .top,
        dismissingAfter timer: TimeInterval = 2,
        @ViewBuilder content: @escaping (I) -> DropView<C, L, T>
    ) -> some View {
        modifier(ItemDropViewPresenter(
            item: item,
            alignment: alignment,
            timer: timer,
            dropView: content
        ))
    }
}
