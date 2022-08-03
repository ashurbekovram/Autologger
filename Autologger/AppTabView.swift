//
//  AppTabView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI
import ProfileService

struct AppTabView: View {
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
                AppViewFactory.shared.createProfileView()
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}
