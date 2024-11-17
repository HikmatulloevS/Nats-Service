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
    print(msg.description)

    do {
        let user = msg.payload
        let payloadData = try JSONEncoder().encode(user)        
        let buffer = ByteBufferAllocator().buffer(capacity: payloadData.count)
        
        
        
        msg.reply(payload: buffer)
    }
    catch {
        debugPrint(error)
    }
}

func UsersLogin(_ msg: NatsMessage) {
    
}

func UsersLogout(_ msg: NatsMessage) {
    
}

func UsersGet(_ msg: NatsMessage) {
    
}

func UsersUpdate(_ msg: NatsMessage) {
    
}
