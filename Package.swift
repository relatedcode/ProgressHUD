// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ProgressHUD",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
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
            path: "ProgressHUD/Sources",
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        ),
    ]
)
