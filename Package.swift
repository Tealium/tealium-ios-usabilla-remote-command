// swift-tools-version:5.1
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
        .package(url: "https://github.com/tealium/tealium-swift", from: "2.1.0"),
        .package(url: "https://github.com/usabilla/usabilla-u4a-ios-swift-sdk", from: "6.5.0")
    ],
    targets: [
        .target(
            name: "TealiumUsabilla",
            dependencies: ["Usabilla", "TealiumCore", "TealiumRemoteCommands", "TealiumTagManagement"],
            path: "./Sources"),
        .testTarget(
            name: "TealiumUsabillaTests",
            dependencies: ["TealiumUsabilla"],
            path: "./Tests")
    ]
)
