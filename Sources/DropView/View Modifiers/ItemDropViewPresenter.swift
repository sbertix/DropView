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
private struct ItemDropViewPresenter<Item: Identifiable, C: View>: ViewModifier {
    /// The drag gesture translation.
    @GestureState var translation: CGFloat = 0

    /// A binding to whether it's being presented or not.
    @Binding var item: Item?
    /// The vertical alignment.
    let alignment: VerticalAlignment
    /// The auto-dismiss time interval.
    let timer: TimeInterval
    /// Whether it should dismiss the drop view on drag or not.
    let shouldDismissOnDrag: Bool
    /// The drop view factory.
    let dropView: (Item) -> C

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
                        !shouldDismissOnDrag
                        ? nil
                        : DragGesture()
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
    ///     - shouldDismissOnDrag: Whether dragging the drop view should dismiss it or not. Defaults to `true`.
    ///     - content: The drop view factory.
    /// - returns: Some `View`.
    @ViewBuilder func drop<I: Identifiable, C: View>(
        item: Binding<I?>,
        alignment: VerticalAlignment = .top,
        dismissingAfter timer: TimeInterval = 2,
        dismissingOnDrag shouldDismissOnDrag: Bool = true,
        @ViewBuilder content: @escaping (I) -> C
    ) -> some View {
        modifier(ItemDropViewPresenter(
            item: item,
            alignment: alignment,
            timer: timer,
            shouldDismissOnDrag: shouldDismissOnDrag,
            dropView: content
        ))
    }
}
