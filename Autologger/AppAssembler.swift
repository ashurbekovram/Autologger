//
//  AppAssembler.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import Foundation
import MakesService
import NetworkManager
import NetworkManagerInterface
import ProfileService
import SwiftUI
import UserAutosService

final class AppAssembler {
    public static var makesService: MakesService = MakesServiceNetwork(networkManager: networkManager)
    public static var networkManager: NetworkManager = NetworkManagerImpl()
    public static var profileService: ProfileService = ProfileServiceLocal()
    public static var userAutosService: UserAutosService = UserAutosServiceLocal()
}
