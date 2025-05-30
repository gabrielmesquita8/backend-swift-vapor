import Vapor
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)

    // Configure local DB connection
    app.databases.use(.postgres(
        hostname: "localhost",
        port: 5432,
        username: "vapor_user",
        password: "vapor_password",
        database: "vapor_db"
    ), as: .psql)

    // Migration
    app.migrations.add(CreateUserTableMigration())
    app.migrations.add(CreateItemTableMigration())
}
