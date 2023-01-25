//
//  ImageManager.swift
//  CatchPokemon
//
//  Created by Camilo Rozo on 18/01/23.
//

import Foundation


protocol ImageManagerDelegate {
    func didUpdateImage(image: ImageModel)
    func didFailWithErrorImage(error: Error)
}

struct ImageManager {
    
    var delegate: ImageManagerDelegate?
    
    
    func fetchImage(url: String) {
        performRequest(with: url)
    }

    private func performRequest(with urlString: String) {
        //    1 create get/url
        if let url = URL(string: urlString) {
        //    2 create the urlSession
            let session = URLSession(configuration: .default)
        //    3 give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
//                    print(error!)
                    self.delegate?.didFailWithErrorImage(error: error!)
                }
                
                if let safeData = data {
                    if let image = self.parseJson(imageData: safeData) {
//                        print(pokemon)
                        self.delegate?.didUpdateImage(image: image)
                    }
                }
            }
            //    4 start the task
            task.resume()
        }
        
        
    }
    
    private func parseJson(imageData: Data) -> ImageModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(ImageData.self, from: imageData)
            let image = decodeData.sprites?.other?.officialArtwork?.frontDefault ?? ""
            return ImageModel(imageURL: image)
        } catch {
            return nil
        }
    }
    
}

