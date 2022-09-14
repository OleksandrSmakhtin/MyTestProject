//
//  DoorForApiImitation.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 14.09.2022.
//

import Foundation

struct DoorsForApiImit: Codable {
    
    let door: Array<DoorForApiImit>
}

struct DoorForApiImit: Codable {
    let title: String
    let position: String
    let status: String
}
