import Fluent
import Vapor
import Nats

func routes(_ app: Application) throws {
    app.post("register") { req async throws -> RegisterRequest in
        let user = try req.content.decode(RegisterRequest.self)
        
        let nats = app.nats
        
        let payloadData = try JSONEncoder().encode(user)
        
        var buffer = ByteBufferAllocator().buffer(capacity: payloadData.count)
        buffer.writeBytes(payloadData)
        
        let answer = try await nats.req("users.register", payload: buffer, timeout: 5000) // Timeout in milliseconds
        print(answer.description)
        
        return RegisterRequest(
            email: user.email,
            password: user.password,
            name: user.name,
            age: user.age)
    }
    
    
}
