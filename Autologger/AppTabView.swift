//
//  AppTabView.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI
import ProfileService

struct AppTabView: View {
    @State var mainFlowCoordinator: Coordinator
    @State var profileFlowCoordinator: Coordinator

    var body: some View {
        TabView {
            NavigationView {
                mainFlowCoordinator.start()
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "house")
                Text("Main")
            }
            NavigationView {
                profileFlowCoordinator.start()
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}
