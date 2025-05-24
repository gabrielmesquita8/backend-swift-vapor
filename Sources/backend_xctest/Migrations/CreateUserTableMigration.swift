import Fluent

struct CreateUserTableMigration: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("joined", .double, .required)
            .unique(on: "email") // in case you want unique names
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("users")
            .delete()
    }
}