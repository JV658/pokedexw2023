//
//  PokemonViewController.swift
//  pokedex
//
//  Created by Cambrian on 2023-01-25.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pokemonURL: String!
    var sprites: Sprite!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Task {
            do{
                let pokeDatails = try await PokeAPI_Helper.fetchPokeDetails(pokeURL: pokemonURL)
                weightLabel.text = String(pokeDatails.weight)
                heightLabel.text = String(pokeDatails.height)
                nameLabel.text = pokeDatails.name
                idLabel.text = String(pokeDatails.id)
                sprites = pokeDatails.sprites
                if let imageURLString = pokeDatails.sprites.front_default {
                    let imageData = try await PokeAPI_Helper.fetchPokeImage(pokeImageURLString: imageURLString)
                    imageView.image = UIImage(data: imageData)
                }
            } catch let err {
                print("Error: \(err)")
            }
        }
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let dst = segue.destination as! PokeImageCollectionViewController
        if let sprites = sprites {
            dst.sprites = sprites
        } else {
            dst.pokeURL = pokemonURL
        }
    }

}
