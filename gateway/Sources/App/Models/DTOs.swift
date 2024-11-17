//
//  DTOs.swift
//  gateway
//
//  Created by Nexus on 11/14/24.
//
import Foundation
import Vapor


struct RegisterRequest: Content {  // DTO - Объект передачи данных
    let email: String
    let password: String
    let name: String
    let age: Int
}

struct LoginRequest: Content {
    let email: String
    let password: String
}

struct UpdateUserRequest: Content {
    let name: String
    let age: Int
}

// DTO ответов
struct UserResponse: Content {
    let id: String
    let email: String
    let name: String
    let age: Int
}

struct LoginResponse: Content {
    let token: String
    let user: UserResponse
}

// Ответ об ошибке
struct ErrorResponse: Content {
    let status: HTTPStatus
    let message: String
}
