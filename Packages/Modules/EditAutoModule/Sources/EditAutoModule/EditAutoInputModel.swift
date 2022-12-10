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
    let vehiclesService: VehiclesService
    let userAutosService: UserAutosService

    public init(
        vehiclesService: VehiclesService,
        userAutosService: UserAutosService
    ) {
        self.vehiclesService = vehiclesService
        self.userAutosService = userAutosService
    }
}
