// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "backend_xctest",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        // Database dependencies
        .package(url: "https://github.com/vapor/fluent.git", from: "4.12.0"),
        .package(url: "https://github.com/vapor/postgres-kit.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "backend_xctest",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                 // Database dependencies
                .product(name: "Fluent", package: "fluent"),
                .product(name: "PostgresKit", package: "postgres-kit"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "backend_xctestTests",
            dependencies: [
                .target(name: "backend_xctest"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
] }
