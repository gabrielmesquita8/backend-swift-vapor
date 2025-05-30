import Fluent
import Vapor

struct ItemController: RouteCollection {

    func boot(routes: any RoutesBuilder) throws {
        let items = routes.grouped("items")
        items.post(use: newItem)
        items.patch(":id", "done", use: markAsDone)
        items.patch(":id", "undone", use: markAsUnDone)
    }
    
    @Sendable func newItem(req: Request) async throws -> Item {
        let item = try req.content.decode(Item.self)
        item.createDate = Date().timeIntervalSince1970
        try await item.save(on: req.db)
        
        return item
    }

   @Sendable func markAsDone(req: Request) async throws -> Item {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Missing or invalid item ID.")
        }

        guard let item = try await Item.find(id, on: req.db) else {
            throw Abort(.notFound, reason: "Item not found.")
        }

        item.isDone = true
        try await item.save(on: req.db)
        return item
    }

    @Sendable func markAsUnDone(req: Request) async throws -> Item {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Missing or invalid item ID.")
        }

        guard let item = try await Item.find(id, on: req.db) else {
            throw Abort(.notFound, reason: "Item not found.")
        }

        item.isDone = false
        try await item.save(on: req.db)
        return item
    }
}