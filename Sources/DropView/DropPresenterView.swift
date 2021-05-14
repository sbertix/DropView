//
//  DropPresenterView.swift
//  Drops
//
//  Created by Stefano Bertagno on 14/05/21.
//

import SwiftUI

/// A `struct` defining a view tasked with presenting `Drop`s.
struct DropPresenterView: View {
    /// An optional `Drop`.
    let drop: Drop?
    /// The vertical alignment.
    let alignment: VerticalAlignment

    /// The underlying view.
    var body: some View {
        drop.flatMap { drop in
            GeometryReader { proxy in
                DropView(drop: drop)
                    .frame(width: 0.9*proxy.size.width)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .init(horizontal: .center, vertical: alignment))
            }
        }
    }
}

#if DEBUG
struct DropPresenterViewPreview: PreviewProvider {
    static var previews: some View {
        DropPresenterView(drop: .init(title: "A notification",
                                      subtitle: "This could be left empty, but we're actually making it super long",
                                      icon: Image(systemName: "circle"),
                                      action: Image(systemName: "chevron.right.circle.fill")),
                          alignment: .bottom)
            .previewLayout(.fixed(width: 400, height: 150))
            .previewDisplayName("Bottom")
        DropPresenterView(drop: .init(title: "A notification",
                                      subtitle: "This could be left empty, but we're actually making it super long",
                                      icon: Image(systemName: "circle"),
                                      action: Image(systemName: "chevron.right.circle.fill")),
                          alignment: .top)
            .environment(\.colorScheme, .dark)
            .previewLayout(.fixed(width: 400, height: 150))
            .previewDisplayName("Top (Dark)")
    }
}
#endif
