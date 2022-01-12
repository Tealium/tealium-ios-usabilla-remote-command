// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "TealiumUsabilla",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "TealiumUsabilla", targets: ["TealiumUsabilla"])
    ],
    dependencies: [
        .package(name: "TealiumSwift", url: "https://github.com/tealium/tealium-swift", .upToNextMajor(from: "2.6.0")),
        .package(name: "Usabilla", url: "https://github.com/usabilla/usabilla-u4a-ios-swift-sdk", .upToNextMajor(from: "6.10.0"))
    ],
    targets: [
        .target(
            name: "TealiumUsabilla",
            dependencies: [
                .product(name: "Usabilla", package: "Usabilla"),
                .product(name: "TealiumCore", package: "TealiumSwift"),
                .product(name: "TealiumRemoteCommands", package: "TealiumSwift")
            ],
            path: "./Sources",
            exclude: ["Support"]),
        .testTarget(
            name: "TealiumUsabillaTests",
            dependencies: ["TealiumUsabilla"],
            path: "./Tests",
            exclude: ["Support"])
    ]
)
