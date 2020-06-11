// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "ProgressHUD",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "ProgressHUD",
            type: .static,
            targets: ["ProgressHUD"]),
    ],
    targets: [
        .target(
            name: "ProgressHUD",
            dependencies: [],
            path: "./ProgressHUD",
            sources: ["Sources"]
        ),
    ]
)
