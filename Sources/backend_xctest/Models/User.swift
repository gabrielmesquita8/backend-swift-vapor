import Fluent
import Vapor

final class User: Model, Content, @unchecked Sendable {
    static let schema: String = "users"
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String
    
    @Field(key: "joined")
    var joined: Double?
    
    // Initialization
    init()  { }
    
    init(id: UUID? = nil, name:String, email:String) {
        self.id = id
        self.name = name
        self.joined = Date().timeIntervalSince1970
    }
}