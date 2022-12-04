<img alt="Notification" src="https://github.com/sbertix/DropView/blob/main/Resources/notification.png" />

<br />

**DropView** is a **SwiftUI**-based library to display alerts inspired by the Apple Pencil and pasteboard stock ones. 

<br />

> What are some features I can expect from this library?

- [x] Dark mode
- [x] Interactive dismissal
- [x] Dynamic font sizing
- [x] Accessibility support
- [x] Custom positioning (`.top`, `.bottom` and `.center`)

<p />

## Status
[![Swift](https://img.shields.io/badge/Swift-5.7-%239872AB?style=flat&logo=swift)](https://swift.org)
![iOS](https://img.shields.io/badge/iOS-14.0-9872AB)
![macOS](https://img.shields.io/badge/macOS-11.0-9872AB)
![tvOS](https://img.shields.io/badge/tvOS-14.0-9872AB)
![watchOS](https://img.shields.io/badge/watchOS-7.0-9872AB)
<br />
[![checks](https://github.com/sbertix/DropView/actions/workflows/push.yml/badge.svg?branch=main)](https://github.com/sbertix/DropView/actions/workflows/push.yml)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/sbertix/DropView)

You can find all changelogs directly under every [release](https://github.com/sbertix/DropView/releases).

> What's next?

[Milestones](https://github.com/sbertix/DropView/milestones) and [issues](https://github.com/sbertix/DropView/issues) are the best way to keep updated with active developement.

Feel free to contribute by sending a [pull request](https://github.com/sbertix/DropView/pulls).
Just remember to refer to our [guidelines](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) beforehand.

<p />

## Installation
### Swift Package Manager (Xcode 11 and above)
1. Select `File`/`Swift Packages`/`Add Package Dependency…` from the menu.
1. Paste `https://github.com/sbertix/DropView.git`.
1. Follow the steps.
1. Add **DropView**.

> Why not CocoaPods, or Carthage, or ~blank~?

Supporting multiple _dependency managers_ makes maintaining a library exponentially more complicated and time consuming.\
Furthermore, with the integration of the **Swift Package Manager** in **Xcode 11** and above, we expect the need for alternative solutions to fade quickly.

<p />

## Usage

**DropView** allows you to present alerts just like `sheet`s and `fullScreenCover`s. 

<details><summary><strong>Example</strong></summary>
    <p>

```swift
import SwiftUI

import DropView

struct DropViewContainer: View {
    /// Whether it's presenting the drop view or not.
    @State var isPresented: Bool = false
    /// The time interval before it auto-dismisses.
    @State var seconds: TimeInterval = 2

    /// The underlying view.
    var body: some View {
        Form {
            Slider(value: $seconds, in: 2...10) { Text("Seconds before it auto-dismisses") }
                .padding(.horizontal)
            
            ControlGroup {
                Button {
                    isPresented = true
                } label: {
                    Text("Present")
                }
                Button(role: .destructive) {
                    isPresented = false
                } label: {
                    Text("Dismiss")
                }
            }
        }
        .drop(isPresented: $isPresented, alignment: .bottom, dismissingAfter: seconds) {
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
        }
    }
}
```
</details>

<p />

## Special thanks

> _Massive thanks to anyone contributing to [omaralbeik/Drops](https://github.com/omaralbeik/Drops) for the inspiration._
