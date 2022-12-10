//
//  EditAutoViewAssembler.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.08.2022.
//

import SwiftUI
import VehiclesServiceInterface
import UserAutosService

public struct EditAutoInputModel {
    let vehiclesService: VehiclesServiceProtocol
    let userAutosService: UserAutosService

    public init(
        vehiclesService: VehiclesServiceProtocol,
        userAutosService: UserAutosService
    ) {
        self.vehiclesService = vehiclesService
        self.userAutosService = userAutosService
    }
}
