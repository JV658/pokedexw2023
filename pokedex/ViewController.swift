//
//  ViewController.swift
//  pokedex
//
//  Created by Cambrian on 2023-01-16.
//

import UIKit

class ViewController: UIViewController {

//    @IBAction func fetchSwapi(_ sender: UIButton) {
//        sender.isEnabled = false
//        Task{
//            do{
//                print(try await SwapiHelper.fetchPeople());
//            } catch let err{
//                print("there was an error with the Swapi API: \(err)")
//            }
//            sender.isEnabled = true
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task{
            do {
                let pokedex = try await PokeAPI_Helper.fetchPokeData()
                print(pokedex.results.first!.name)
            } catch let er{
                print("error occured: \(er)")
            }
        }
        
//        PokeAPI_Helper.fetchPokeData(callback: {
//            response in
//
//            switch response {
//            case .success(let data):
//                print(data)
//            case .failure(let err):
//                print(err)
//            }
//        })
        

    }


}

