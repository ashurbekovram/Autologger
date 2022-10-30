//
//  AuthView.swift
//  
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import SwiftUI

public struct AuthView: View {
    @StateObject private var viewModel: AuthViewModel

    public init() {
        _viewModel = StateObject(wrappedValue: AuthViewModel())
    }

    public var body: some View {
        ScrollView {
            VStack {
                TextField("Login", text: $viewModel.login)
                TextField("Password", text: $viewModel.password)
                Button("Login") {
                    print("Login button tapped")
                }
            }
            .padding()
        }
        .navigationTitle("Auth")
    }
}

// MARK: - PreviewProvider
struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
