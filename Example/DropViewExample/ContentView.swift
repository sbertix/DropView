//
//  ContentView.swift
//  Ciaone
//
//  Created by Stefano Bertagno on 04/12/22.
//

import SwiftUI

import DropView

enum Kind: String, Identifiable {
    case one
    case two

    var id: String { rawValue }
}

struct ContentView: View {
    /// Whether it's presenting the drop view or not.
    @State var item: Kind?
    /// The vertical alignment.
    @State var alignment: HashableVerticalAlignment = .top
    /// The time interval before it auto-dismisses.
    @State var timer: TimeInterval = 2
    /// Whether it should auto-dismiss or not.
    @State var shouldAutoDismiss: Bool = true
    /// Whether the drop view should be dismissed on drag or not.
    @State var shouldDismissOnDrag: Bool = true

    /// The underlying view.
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("General")) {
                    Picker("Vertical alignment", selection: $alignment) {
                        Text("Top").tag(HashableVerticalAlignment.top)
                        Text("Center").tag(HashableVerticalAlignment.center)
                        Text("Bottom").tag(HashableVerticalAlignment.bottom)
                    }
                    Toggle("Drag to dismiss", isOn: $shouldDismissOnDrag)
                }

                Section(header: Text("Auto dismiss")) {
                    Stepper(
                        "Timer \(Int(timer))s",
                        value: $timer,
                        in: 2 ... 10
                    )
                    .disabled(!shouldAutoDismiss)
                    Toggle("Auto dimiss", isOn: $shouldAutoDismiss)
                }

                ControlGroup {
                    Button {
                        item = .one
                    } label: {
                        Text("Default DropView")
                    }
                    Button {
                        item = .two
                    } label: {
                        Text("Custom View")
                    }
                    Button(role: .destructive) {
                        item = nil
                    } label: {
                        Text("Dismiss")
                    }
                }
            }
            .navigationTitle("DropView")
        }
        .drop(
            item: $item,
            alignment: alignment.alignment,
            dismissingAfter: shouldAutoDismiss ? timer : .greatestFiniteMagnitude,
            dismissingOnDrag: shouldDismissOnDrag
        ) {
            switch $0 {
            case .one:
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
            default:
                VStack(alignment: .leading, spacing: 2) {
                    Text("This is not a DropView")
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(
                        """
                        You can now use whatever you want inside of the `drop` view builder,\
                        getting position, transitions,\
                        animations and drag gesture behavior for free.
                        """
                    )
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                }
                .multilineTextAlignment(.leading)
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color(.separator), lineWidth: 1)
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
