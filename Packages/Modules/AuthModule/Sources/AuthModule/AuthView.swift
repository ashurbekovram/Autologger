//
//  AuthView.swift
//  
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import SwiftUI

public struct AuthView: View {
    @StateObject private var viewModel: AuthViewModel

    public init(inputModel: AuthInputModel) {
        _viewModel = StateObject(wrappedValue: AuthViewModel(
            authService: inputModel.authService,
            profileService: inputModel.profileService
        ))
    }

    public var body: some View {
        ScrollView {
            VStack {
                TextField("Username", text: $viewModel.username)
                TextField("Password", text: $viewModel.password)
                Button("Login") {
                    print("Login button tapped")
                    viewModel.login()
                }
            }
            .padding()
        }
        .navigationTitle("Auth")
    }
}

// MARK: - PreviewProvider
//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView()
//    }
//}
