// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BluetoothMessageProtocol",
    products: [
        .library(name: "BluetoothMessageProtocol", targets: ["BluetoothMessageProtocol"])
    ],
    dependencies: [
        .package(url: "https://github.com/FitnessKit/FitnessUnits", from: "2.0.2"),
        .package(url: "https://github.com/FitnessKit/DataDecoder", from: "4.0.3"),
    ],
    targets: [
        .target(
            name: "BluetoothMessageProtocol",
            dependencies: [
                "FitnessUnits",
                "DataDecoder",
            ]
        ),
        .testTarget(
            name: "BluetoothMessageProtocolTests",
            dependencies: [
                "BluetoothMessageProtocol"
                ]
        ),

    ],
    swiftLanguageVersions: [3, 4]
)
