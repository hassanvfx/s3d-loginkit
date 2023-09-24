// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "S3DLoginKit",
    platforms: [
           .iOS(.v15), // Set the minimum iOS version to 16
           .macOS(.v10_15)
       ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "S3DLoginKit",
            targets: ["S3DLoginKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url:"https://github.com/hassanvfx/s3d-coremodels.git", .upToNextMajor(from: "0.0.1")),
        .package(url:"https://github.com/hassanvfx/s3d-coreui.git", .upToNextMajor(from: "0.0.9")),
        .package(url:"https://github.com/hassanvfx/s3d-baseapi.git", .upToNextMajor(from: "0.0.9")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "S3DLoginKit",
            dependencies: [
                .product(name: "S3DCoreModels", package: "s3d-coremodels"),
                .product(name: "S3DCoreUI", package: "s3d-coreui"),
                .product(name: "S3DBaseAPI", package: "s3d-baseapi"),
            ]),
        .testTarget(
            name: "S3DLoginKitTests",
            dependencies: ["S3DLoginKit"]),
    ]
)
