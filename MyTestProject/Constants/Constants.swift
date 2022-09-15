//
//  Constants.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 12.09.2022.
//

import Foundation

struct K {
    
    struct DoorStatus {
        static let unlocked = "Unlocked"
        static let locked = "Locked"
        static let unlocking = "Unlocking..."
    }
    
    struct StatusImagesNames {
        static let shieldLocked = "shieldLocked"
        static let shieldUnlocked = "shieldUnlocked"
        static let shieldUnlocking = "shieldUnlocking"
        static let doorLocked = "doorLocked"
        static let doorUnlocked = "doorUnlocked"
        static let doorUnlocking = "doorUnlocking"
        
    }
    
    struct Cells {
        static let doorCell = "DoorCell"
        static let loadingCell = "LoadingCell"
    }
    
    struct uiElements {
        static let setting = "Setting"
        static let welcome = "Welcome"
        static let interQR = "interQR"
        static let home = "Home"
    }
    
}
