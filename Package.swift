// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "ProgressHUD",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "ProgressHUD",
            targets: ["ProgressHUD"]
        ),
    ],
    targets: [
        .target(
            name: "ProgressHUD",
            dependencies: [],
            path: "SwiftUI/Sources",
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        ),
    ]
)
