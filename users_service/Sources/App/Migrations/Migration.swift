//
//  Migration.swift
//  users_service
//
//  Created by Nexus on 11/16/24.
//

import Foundation
import Vapor
import Fluent


struct UserMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("user")
            .id()
            .field(.email, .string)
            .field(.password, .string)
            .field(.age, .int)
            .field(.name, .string)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("user").delete()
    }
}
