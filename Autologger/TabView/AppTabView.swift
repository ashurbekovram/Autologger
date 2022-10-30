//
//  AppTabView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI
import ProfileService

struct AppTabView: View {
    @StateObject var viewModel: AppTabViewModel

    init(inputModel: AppTabInputModel) {
        _viewModel = StateObject(wrappedValue: AppTabViewModel(
            profileService: inputModel.profileService,
            appTabFactory: inputModel.viewFactory
        ))
    }

    var body: some View {
        TabView {
            NavigationView {
                AppViewFactory.shared.createMainView()
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "house")
                Text("Main")
            }
            NavigationView {
                if viewModel.profile != nil {
                    viewModel.appTabFactory.createProfileView()
                } else {
                    viewModel.appTabFactory.createAuthView()
                }
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

// MARK: - PreviewProvider
struct AppTabView_Previews: PreviewProvider {
	static var previews: some View {
		AppTabView(inputModel: AppTabInputModel(
			viewFactory: AppViewFactory.shared,
			profileService: AppAssembler.profileService
		))
	}
}
