//
//  Character.swift
//  RandomRAMCharacter
//
//  Created by Daniil Klimenko on 17.06.2022.
//

import Foundation

// MARK: - Welcome
struct Character: Codable {
    let name, status, species, gender: String?
    let type: String?
    let location: Location
    let image: String?
    
}

// MARK: - Location
struct Location: Codable {
    let name: String?
}
