// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ScrollOffset",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ScrollOffset",
            targets: ["ScrollOffset"]
        ),
    ],
    targets: [
        .target(
            name: "ScrollOffset",
            path: "Sources/ScrollOffset"
        ),
    ]
)
