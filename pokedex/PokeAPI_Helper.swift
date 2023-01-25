//
//  PokeAPI_Helper.swift
//  pokedex
//
//  Created by Cambrian on 2023-01-16.
//

import Foundation

enum PokeAPI_Errors: Error {
    case unableToConvertURL
    case INVALID_URL
    case nilData
    case CannotParseJSONData
}

enum PokeAPI_Response {
    case success(Any)
    case failure(Error)
}

class PokeAPI_Helper {
    static let urlString = "https://pokeapi.co/api/v2/pokemon"
    
    static func fetchPokeData() async throws -> Pokedex {
        
        guard
            let url = URL(string: urlString)
        else { throw PokeAPI_Errors.unableToConvertURL}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        
        let pokedex = try decoder.decode(Pokedex.self, from: data)
        
        return pokedex
    }
    
    
    
    
    
    
    
    
    
    
    
    
    static func fetchPokeData(callback: @escaping (PokeAPI_Response)->Void){
        guard
            let url = URL(string: urlString)
        else {
            callback(.failure(PokeAPI_Errors.unableToConvertURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {
            
            data, _, error in
            
            if let error = error {
                callback(.failure(error))
            }
            
            if let data = data {
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    callback(.success(jsonObject))
                } catch let err {
                    callback(.failure(err))
                }
            } else {
                callback(.failure(PokeAPI_Errors.nilData))
            }

        }
        task.resume()
    }
}
