// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "DropView",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [.library(name: "DropView", targets: ["DropView"])],
    targets: [.target(name: "DropView", dependencies: [])]
)
