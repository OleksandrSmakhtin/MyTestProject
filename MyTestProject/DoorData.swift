//
//  DoorData.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 12.09.2022.
//

import Foundation

class DoorData {
    static let instance = DoorData()
    
    func getDoors() -> [Door] {
        
        let doors = [
            Door(title: "Front door", position: "Home", status: K.DoorStatus.locked, shieldImage: K.StatusImagesNames.shieldLocked, doorImage: K.StatusImagesNames.doorLocked),
            Door(title: "Back door", position: "Home", status: K.DoorStatus.locked, shieldImage: K.StatusImagesNames.shieldLocked, doorImage: K.StatusImagesNames.doorLocked),
            Door(title: "Front door", position: "Office", status: K.DoorStatus.locked, shieldImage: K.StatusImagesNames.shieldLocked, doorImage: K.StatusImagesNames.doorLocked),
            Door(title: "Emergancy door", position: "Office", status: K.DoorStatus.locked, shieldImage: K.StatusImagesNames.shieldLocked, doorImage: K.StatusImagesNames.doorLocked)
        ]
        
        return doors
        
    }
}
