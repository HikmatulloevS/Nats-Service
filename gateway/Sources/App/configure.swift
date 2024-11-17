import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import Nats

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)
    app.nats = Nats(eventLoop: app.eventLoopGroup.next())
    try await app.nats.start(config: .init(url: URL(string: "nats://localhost:4222"))).get()
    // register routes
    try routes(app)
    
}


extension Application {
    struct NatsKey: StorageKey {
        typealias Value = Nats
    }
    
    var nats: Nats {
        get {
            if let existing = self.storage[NatsKey.self] {
                return existing
            }
            fatalError("Nats not configured")
        }
        set {
            self.storage[NatsKey.self] = newValue
        }
    }
}
