//
//  UserService.swift
//  users_service
//
//  Created by Nexus on 11/16/24.
//

import Nats
import Foundation
import Vapor

func natsRoutes(_ nats: Nats) async {
    do {
        try await nats.sub("users.register", callback: UsersRegister)
        try await nats.sub("users.login", callback: UsersLogin)
        try await nats.sub("users.logout", callback: UsersLogout)
        try await nats.sub("users.get", callback: UsersGet)
        try await nats.sub("users.update", callback: UsersUpdate)
    }
    catch {
        debugPrint(error) // Need to sent error struct
    }
}

func UsersRegister(_ msg: NatsMessage) {
    do {
            // Декодируем msg.payload в объект типа User
        let user = try JSONDecoder().decode(User.self, from: msg.payload)

        let userToSave = User(email: user.email, password: user.password, age: user.age, name: user.name)
        save_user(user: userToSave)
        
        let confirmation = "User registered successfully"
        var buffer = ByteBufferAllocator().buffer(capacity: confirmation.count)
        buffer.writeString(confirmation)
        msg.reply(payload: buffer)
    } catch {
        debugPrint(error)
    }
}

func save_user(user: User) {
    let app = Application()
    user.save(on: app.db)
}


func UsersLogin(_ msg: NatsMessage) {
    
}

func UsersLogout(_ msg: NatsMessage) {
    
}

func UsersGet(_ msg: NatsMessage) {
    
}

func UsersUpdate(_ msg: NatsMessage) {
    
}


struct RegisterRequest: Content {  // DTO - Объект передачи данных
    let email: String
    let password: String
    let name: String
    let age: Int
}
