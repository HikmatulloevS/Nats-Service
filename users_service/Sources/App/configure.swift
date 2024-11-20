import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import Nats

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(
            .postgres(
                configuration: .init(
                    hostname: "localhost",
                    port: 5433,
                    username: "postgres",
                    password: "",
                    database: "postgres",
                    tls: .disable
                )
            ),
            as: .psql
        )
    app.http.server.configuration.port = 8081
    app.nats = Nats(eventLoop: app.eventLoopGroup.next())
    try await app.nats.start(config: .init(url: URL(string: "nats://localhost:4222"))).get()
    // register routes

    await natsRoutes(app.nats)
    app.migrations.add(UserMigration())
    try await app.autoMigrate()
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
