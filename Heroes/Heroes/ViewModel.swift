//
//  ViewModel.swift
//  Heroes
//
//  Created by mac on 2023. 02. 21..
//

import Foundation
import SwiftUI
private struct Returned: Codable {
    var avengers: [Hero]
}

struct Hero: Codable, Hashable {
    let name: String
    let imageURL: String
    let latitude: Double
    let longitude: Double
}

class ViewModel: ObservableObject{
    
    @Published var heroes: [Hero] = []
    
    func fetch(){
        guard let url = URL(string: "http://www.mocky.io/v2/5addd58b30000066154b28c9") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _,
            error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let heroes = try JSONDecoder().decode(Returned.self, from: data)
                DispatchQueue.main.async {
                    self?.heroes = heroes.avengers
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
