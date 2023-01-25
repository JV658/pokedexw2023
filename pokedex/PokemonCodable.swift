//
//  PokemonCodable.swift
//  pokedex
//
//  Created by Cambrian on 2023-01-23.
//

import Foundation

struct Pokedex: Codable{
    var results: [Pokemon]
    var next: String
}

struct Pokemon: Codable {
    var name: String
    var url: String
}
