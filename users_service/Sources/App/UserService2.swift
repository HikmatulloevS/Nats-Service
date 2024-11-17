//
//  UserService2.swift
//  users_service
//
//  Created by Nexus on 11/17/24.
//
import Nats
import Foundation
import Vapor


struct NatsRoutes: RouterDelegate {
    func onOpen(_ nats: Nats) {
        nats.subscribe("users.register") { msg in
            print("Incoming message to users.register", msg.description)
//            do {
//                let user = msg.payload
//                let payloadData = try JSONEncoder().encode(user)
//                let buffer = ByteBufferAllocator().buffer(capacity: payloadData.count)
//                
//                msg.reply(payload: buffer)
//            }
//            catch {
//                debugPrint(error)
//            }
        }.whenSuccess {_ in
            print("Successfully subscribed to test.message")
        }
    }
    
    
    
    func onReconnect(_ nats: Nats) {
    }
    
    func onStreamingOpen(_ nats: Nats) {
    }
    
    func onClose(_ nats: Nats) {

    }
    
    func onError(_ nats: Nats, _ error: any Error) {
        
    }
    
    
}


struct UserResponse: Content {
    let id: String
    let email: String
    let name: String
    let age: Int
}
