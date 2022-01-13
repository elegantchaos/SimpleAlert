// swift-tools-version:5.5

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 10/09/2021.
//  All code (c) 2021 - present day, Elegant Chaos.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
    name: "SimpleAlert",
    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v5)
    ],
    products: [
        .library(
            name: "SimpleAlert",
            targets: ["SimpleAlert"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/XCTestExtensions.git", from: "1.3.3")
    ],
    targets: [
        .target(
            name: "SimpleAlert",
            dependencies: []),
        .testTarget(
            name: "SimpleAlertTests",
            dependencies: ["SimpleAlert", "XCTestExtensions"]),
    ]
)
