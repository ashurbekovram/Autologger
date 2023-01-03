//
//  AuthInputModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.01.2023.
//

import AuthServiceInterface

public struct AuthInputModel {
    let authService: AuthService

    public init(authService: AuthService) {
        self.authService = authService
    }
}
