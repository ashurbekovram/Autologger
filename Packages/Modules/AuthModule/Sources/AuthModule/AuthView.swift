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
        Text("Auth")
    }
}
