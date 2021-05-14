<img alt="Notification" src="https://github.com/sbertix/DropView/blob/main/Resources/notification.png" />

<br />

**DropView** is a **SwiftUI**-based library to display alerts inspired by the Apple Pencil and pasteboard stock ones. 

<p />

## Status
[![Swift](https://img.shields.io/badge/Swift-5.2-%239872AB?style=flat&logo=swift)](https://swift.org)
![iOS](https://img.shields.io/badge/iOS-13.0-9872AB)
![macOS](https://img.shields.io/badge/macOS-10.15-9872AB)
![tvOS](https://img.shields.io/badge/tvOS-13.0-9872AB)
![watchOS](https://img.shields.io/badge/watchOS-6.0-9872AB)
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
Furthermore, with the integration of the **Swift Package Manager** in **Xcode 11** and greater, we expect the need for alternative solutions to fade quickly.

<p />

## Usage

**DropView** allows you to present alerts just like `sheet`s and `fullScreenCover`s. 

Just call `.drop($drop)` on any `View`. 

<details><summary><strong>Example</strong></summary>
    <p>

```swift
import SwiftUI

import DropView

struct YourView: View {
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
```
</details>

<p />

## Special thanks

> _Massive thanks to anyone contributing to [omaralbeik/Drops](https://github.com/omaralbeik/Drops) for the inspiration._

