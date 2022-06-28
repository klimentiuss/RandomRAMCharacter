//
//  ViewController.swift
//  RandomRAMCharacter
//
//  Created by Daniil Klimenko on 17.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backRick")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func getButtonPressed(_ sender: Any) {
        fetchCharacter()
    }
    
}
extension ViewController {
    
    func fetchCharacter() {
        
        let randomNumber = Int.random(in: 1...826)
        
        let url = "https://rickandmortyapi.com/api/character/\(randomNumber)"
        
        print(url)
        
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            
            guard let data = data else { return }
            
            //MARK: - Testing work JSON | Delete after test
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString ?? "FUCK")
            
            do {
                let someCharacter = try JSONDecoder().decode(Character.self, from: data)
                print(someCharacter.image ?? "No desc")
                
                DispatchQueue.global().async {
                    guard let stringUrl = someCharacter.image else { return }
                    guard let imageUrl = URL(string: stringUrl) else { return }
                    guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                    
                    DispatchQueue.main.async {
                        self.characterImage.image = UIImage(data: imageData)
                        self.informationLabel.text =
"""
Name: \(someCharacter.name ?? "Error")
Status: \(someCharacter.status ?? "Error")
Species: \(someCharacter.species ?? "Error")
Gender: \(someCharacter.gender ?? "Error")
Last seen: \(someCharacter.location.name ?? "Error")
"""
                        
                        
                    }
                    
                }
                
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
}



