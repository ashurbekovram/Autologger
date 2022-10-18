//
//  AuthViewModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import Foundation

final class AuthViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""

    init() {}
}
