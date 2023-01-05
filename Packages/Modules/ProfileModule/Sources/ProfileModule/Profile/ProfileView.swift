//
//  ProfileView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI
import UIComponents

public struct ProfileView: View  {
    @StateObject var viewModel: ProfileViewModel

    public init(inputModel: ProfileInputModel) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(
            viewFactory: inputModel.viewFactory,
            profileService: inputModel.profileService,
            authService: inputModel.authService
        ))
    }

    public var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack {
                    VStack(alignment: .leading, spacing: 16) {
                        if let error = viewModel.error {
                            Text(error.localizedDescription)
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                        }
                        if let profile = viewModel.profile {
                            Text("My information")
                                .font(.system(size: 22, weight: .semibold, design: .default))
                            ProfileInfoSmallView(
                                email: profile.email,
                                username: profile.username,
                                imageURL: profile.imageURL,
                                mode: .large
                            )
                        } else {
                            Text("Profile data is empty")
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color("BackgroundPrimary"))
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    viewModel.viewFactory.createEditProfileView()
                } label: {
                    Text("Edit")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    viewModel.logout()
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            print("\(type(of: self)) onDisappear")
        }
    }
}
