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

struct PokeDetails: Codable{
    var name: String
    var id: Int
    var height: Int
    var weight: Int
    var sprites: Sprite
}

struct Sprite: Codable {
    var front_default: String?
}

