// swift-tools-version:5.2
import PackageDescription

let package = Package(
    // A server-side Swift Lambda Client for Vapor
    name: "vapor-lambda-client",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "VaporLambdaClient", targets: ["VaporLambdaClient"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),

        // 📦 A server-side AWS Swift SDK
        .package(name: "AWSSDKSwift", url: "https://github.com/swift-aws/aws-sdk-swift.git", from: "4.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            "VaporLambdaClient",
            .product(name: "Vapor", package: "vapor"),
        ]),
        .target(name: "VaporLambdaClient", dependencies: [
            .product(name: "Lambda", package: "AWSSDKSwift"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ]),
    ]
)
