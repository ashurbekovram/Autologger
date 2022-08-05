//
//  EditAutoViewAssembler.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.08.2022.
//

import SwiftUI
import MakesServiceInterface
import UserAutosService

public struct EditAutoInputModel {
    let makesService: MakesService
    let userAutosService: UserAutosService

    public init(
        makesService: MakesService,
        userAutosService: UserAutosService
    ) {
        self.makesService = makesService
        self.userAutosService = userAutosService
    }
}
