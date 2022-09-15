//
//  DoorData.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 12.09.2022.
//

import Foundation

class DoorData {
    static let instance = DoorData()

    var doors = [
        Door(title: "Front door", position: "Home", status: K.DoorStatus.locked),
        Door(title: "Back door", position: "Home", status: K.DoorStatus.locked),
        Door(title: "Front door", position: "Office", status: K.DoorStatus.locked),
        Door(title: "Emergancy door", position: "Office", status: K.DoorStatus.locked)
    ]
    
    func getDoors() -> [Door] {
        return doors
    }
}
