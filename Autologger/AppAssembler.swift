//
//  AppAssembler.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import Foundation
import AuthService
import AuthServiceInterface
import VehiclesService
import VehiclesServiceInterface
import NetworkManager
import NetworkManagerInterface
import ProfileService
import ProfileServiceInterface
import SwiftUI
import UserAutosService

final class AppAssembler {
    public static var vehiclesService: VehiclesService = VehiclesServiceImp(networkManager: networkManager)
    public static var networkManager: NetworkManager = NetworkManagerImpl()
    public static var profileService: ProfileService = ProfileServiceImp(networkManager: networkManager)
    public static var userAutosService: UserAutosService = UserAutosServiceLocal()
    public static var authService: AuthService = AuthServiceImp(networkManager: networkManager)
}
