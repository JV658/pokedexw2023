//
//  SwapiHelper.swift
//  pokedex
//
//  Created by Cambrian on 2023-01-18.
//

import Foundation

enum SwapiErrors: Error{
    case unableToCreateURL
}

class SwapiHelper {
    static let urlString = "https://swapi.dev/api/people"
    
    static func fetchPeople() async throws -> Any {
        guard
            let url = URL(string: urlString)
        else { throw SwapiErrors.unableToCreateURL}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        
        return jsonObject
    }
}
