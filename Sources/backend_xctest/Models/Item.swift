import Fluent
import Vapor

final class Item: Model, Content, @unchecked Sendable {
    static let schema: String = "item"
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "createDate")
    var createDate: Double?

    @Field(key: "isDone")
    var isDone: Bool
    
    // Initialization
    init()  { }
    
    init(id: UUID? = nil, title:String, isDone:Bool) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.createDate = Date().timeIntervalSince1970
    }
}