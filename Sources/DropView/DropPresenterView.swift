//
//  DropPresenterView.swift
//  Drops
//
//  Created by Stefano Bertagno on 14/05/21.
//

import Combine
import SwiftUI

/// A `struct` defining a view tasked with presenting `Drop`s.
internal struct DropPresenterView: View {
    /// The gesture state.
    @GestureState var translation: CGFloat = 0
    /// The time when it should hide.
    @State var date: Date

    /// An optional `Drop` binding.
    @Binding var drop: Drop?
    /// The vertical alignment.
    let alignment: VerticalAlignment
    /// Seconds before autohiding.
    let seconds: TimeInterval

    /// The current offset.
    private var offset: CGFloat {
        switch alignment {
        case .top:
            return min(translation, 0)
        case .bottom:
            return max(0, translation)
        default:
            return 0
        }
    }

    /// The current opacity.
    ///
    /// - note:
    ///     Opacity is computed as the ratio between the current translation
    ///     and an arbitrary number. This might be improved on but it proves
    ///     good enough in most cases.
    private var opacity: Double {
        switch alignment {
        case .top where translation < 0,
             .bottom where translation > 0,
             .center:
            return max(1 - pow(Double(abs(translation)) / 60, 3), 0)
        default:
            return 1
        }
    }

    /// The current scale.
    private var scale: CGFloat {
        switch alignment {
        case .center:
            return CGFloat(opacity)
        default:
            return 1
        }
    }

    /// The transition.
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

    /// The underlying view.
    var body: some View {
        drop.flatMap { drop in
            GeometryReader { proxy in
                DropView(drop: drop)
                    .offset(x: 0, y: offset)
                    .opacity(opacity)
                    .scaleEffect(scale)
                    .gesture(DragGesture(coordinateSpace: .local)
                                .updating($translation) { change, state, _ in
                                    state = change.translation.height
                                }
                                .onChanged { _ in self.date = .distantFuture }
                                .onEnded {
                                    defer { self.date = .init(timeIntervalSinceNow: seconds) }
                                    let predicated = $0.predictedEndLocation.y
                                    let end = $0.location.y
                                    let start = $0.startLocation.y
                                    let delta: CGFloat
                                    switch alignment {
                                    case .center where min(predicated, end) < start,
                                         .top where min(predicated, end) < start:
                                        delta = abs(min(predicated, end) - start)
                                    case .center where max(predicated, end) > start,
                                        .bottom where max(predicated, end) > start:
                                        delta = abs(max(predicated, end) - start)
                                    default:
                                        delta = 0
                                    }
                                    // Dismiss if the delta is greater than `50`.
                                    guard delta > 50 else { return }
                                    self.drop = nil
                                })
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .frame(width: 0.9 * proxy.size.width)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .init(horizontal: .center, vertical: alignment))
                    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) {
                        guard $0 >= date else { return }
                        self.drop = nil
                    }
            }
        }
        .transition(transition)
        .onReceive(Just(drop?.id).receive(on: RunLoop.main)) {
            date = $0 == nil ? .distantFuture : .init(timeIntervalSinceNow: seconds)
        }
    }

    /// Init.
    ///
    /// - parameters:
    ///     - drop: An optional `Drop` binding.
    ///     - alignment: A valid `VerticalAlignment`.
    ///     - seconds: A valid `TimeInterval`.
    init(drop: Binding<Drop?>,
         alignment: VerticalAlignment,
         seconds: TimeInterval) {
        self._drop = drop
        self._date = .init(initialValue: .init(timeIntervalSinceNow: seconds))
        self.alignment = alignment
        self.seconds = seconds
    }
}
