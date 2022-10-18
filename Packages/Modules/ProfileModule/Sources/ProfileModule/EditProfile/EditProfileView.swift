//
//  EditProfileView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI

public struct EditProfileView: View {
//    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: EditProfileViewModel

    public init(inputModel: EditProfileInputModel) {
        _viewModel = StateObject(wrappedValue: EditProfileViewModel(
            profileService: inputModel.profileService
        ))
    }

    public var body: some View {
        Form {
            Section {
                TextField("Enter name", text: $viewModel.name)
                    .disabled(viewModel.isLoading)
                TextField("Enter second name", text: $viewModel.secondName)
                    .disabled(viewModel.isLoading)
            }
            Section {
                Button {
                    viewModel.updateProfile()
                } label: {
                    HStack {
                        Text("Save")
                        if viewModel.isLoading {
                            Spacer()
                            ProgressView()
                        }
                    }
                }
                .disabled(viewModel.isLoading)
            }
        }
        .navigationTitle("Edit profile")
    }
}
