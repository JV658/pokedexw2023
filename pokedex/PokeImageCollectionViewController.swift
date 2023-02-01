//
//  PokeImageCollectionViewController.swift
//  pokedex
//
//  Created by Cambrian on 2023-02-01.
//

import UIKit

class PokeImageCollectionViewController: UICollectionViewController {

    var sprites: Sprite!
    var availableSpriteURL: [String] = []
    
    var pokeURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        if sprites != nil {
            availableSpriteURL = getAvailableImageURLs(sprites: sprites)
        } else {
            Task{
                do {
                    let pokemonDetails = try await PokeAPI_Helper.fetchPokeDetails(pokeURL: pokeURL)
                    availableSpriteURL = getAvailableImageURLs(sprites: pokemonDetails.sprites)
                    collectionView.reloadData()
                } catch {
                    print(error)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return availableSpriteURL.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeImage", for: indexPath) as! PokeImageCollectionViewCell
    
        // Configure the cell
        let url = availableSpriteURL[indexPath.row]
        Task {
            do {
                let data = try await PokeAPI_Helper.fetchPokeImage(pokeImageURLString: url)
                cell.pokeImageView.image = UIImage(data: data)
            } catch {
                print(error)
            }
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

func getAvailableImageURLs(sprites: Sprite) -> [String]{
    var availableSpriteURL: [String] = []
    if let frontDefault = sprites.front_default{
        availableSpriteURL.append(frontDefault)
    }
    if let backDefault = sprites.back_default {
        availableSpriteURL.append(backDefault)
    }
    if let frontFemale = sprites.front_female{
        availableSpriteURL.append(frontFemale)
    }
    if let backFemale = sprites.back_female{
        availableSpriteURL.append(backFemale)
    }
    return availableSpriteURL
}
