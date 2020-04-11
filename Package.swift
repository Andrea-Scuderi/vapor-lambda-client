// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "LocalLambdaGateway",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "LocalLambdaGateway", targets: ["App"]),
        .library(name: "LambdaHandler", targets: ["LambdaHandler"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),

        .package(name: "AWSSDKSwift", url: "https://github.com/swift-aws/aws-sdk-swift.git", from: "4.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            "LambdaHandler",
            .product(name: "Vapor", package: "vapor"),
        ]),
        .target(name: "LambdaHandler", dependencies: [
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
