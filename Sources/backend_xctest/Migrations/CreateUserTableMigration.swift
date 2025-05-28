import Fluent

struct CreateUserTableMigration: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("joined", .double, .required)
            .unique(on: "email")
            .create()

        try await database.schema("items")
            .id()
            .field("title", .string, .required)
            .field("createDate", .double, .required)
            .field("isDone", .bool, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("users")
            .delete()
        try await database.schema("items")
            .delete()
    }
}