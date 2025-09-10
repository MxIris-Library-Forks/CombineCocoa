// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "CombineCocoa",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "CombineCocoa", targets: ["CombineCocoa"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "CombineCocoa", dependencies: ["CombineCocoaRuntime"]),
        .target(name: "CombineCocoaRuntime", dependencies: []),
    ],
    swiftLanguageModes: [.v5]
)
