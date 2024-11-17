//
//  User.swift
//  users_service
//
//  Created by Nexus on 11/16/24.
//

import Foundation
import Fluent
import Vapor

final class User: Model {
    static let schema = "user"
    
    @ID(key: .id) var id: UUID?
    
    @Field(key: .email) var email: String
    
    @Field(key: .password) var password: String
    
    @Field(key: .age) var age: Int
    
    @Field(key: .name) var name: String
    
    init() {}
    
    init(email: String, password: String, age: Int, name:  String) {
        self.email = email
        self.password = password
        self.age = age
        self.name = name
    }
    
}

extension FieldKey {
    static var email: Self {"email"}
    static var password: Self {"password"}
    static var age: Self {"age"}
    static var name: Self {"name"}
}
