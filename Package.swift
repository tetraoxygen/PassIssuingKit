// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PassIssuingKit",
	platforms: [
		.macOS(.v11)
	],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PassIssuingKit",
            targets: ["PassIssuingKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
		.package(url: "https://github.com/aydenp/PassEncoder.git", revision: "edef6e1620d1f4c2a269a5edf467e0d4f123b68f")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PassIssuingKit",
            dependencies: [
				.product(name: "PassEncoder", package: "PassEncoder")
			]),
        .testTarget(
            name: "PassIssuingKitTests",
            dependencies: ["PassIssuingKit"]),
    ]
)
