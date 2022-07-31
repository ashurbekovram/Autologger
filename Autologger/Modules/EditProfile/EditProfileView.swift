//
//  EditProfileView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI

struct EditProfileView<ViewModel: EditProfileViewModelProtocol>: View {
//    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ViewModel

    var body: some View {
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
