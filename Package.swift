// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SamplePackageToCallCasperSDKObjectiveC",
    platforms: [
        .iOS(.v13), .tvOS(.v12), .watchOS(.v5), .macOS(.v10_15)
        ],
    products: [
        .library(
            name: "LibAll",
            targets: ["LibCoreTarget", "LibFullTarget"]
        ),
        .library(
            name: "LibCore",
            targets: ["LibCoreTarget"]
        ),
        .library(
            name: "LibFull",
            targets: ["LibFullTarget"]
        )
    ],
    dependencies: [
        .package(name: "CasperSDKObjectiveC", url: "https://github.com/tqhuy2018/Casper-ObjectiveC-sdk.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "LibCoreTarget",
            dependencies: ["CasperSDKObjectiveC"],
            path: "Sources/Core",
            publicHeadersPath: "Public"
        ),
        .target(
            name: "LibFullTarget",
            dependencies: ["LibCoreTarget"],
            path: "Sources/Full",
            publicHeadersPath: "Public"
        )
       
    ]
)
