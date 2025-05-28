import Fluent
import Vapor

struct UserController: RouteCollection {

    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.post(use: registerUser)
    }
    
     @Sendable func registerUser(req: Request) async throws -> User {
        let user = try req.content.decode(User.self)
        user.joined = Date().timeIntervalSince1970
        try await user.save(on: req.db)
        
        return user
    }
}