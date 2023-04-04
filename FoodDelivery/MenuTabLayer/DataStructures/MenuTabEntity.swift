//
//  MenuTabEntity.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import Foundation

struct MenuTabEntity: Codable {
    let id: Int
    let title: String
    let image: String
    let restaurantChain: String
    var cathegory: String
    
    init?(model: MenuItem, cathegory: String) {
        guard let id = model.id,
              let title = model.title,
              let image = model.image,
              let restaurantChain = model.restaurantChain else { return nil }
        
        self.id = id
        self.title = title
        self.image = image
        self.restaurantChain = restaurantChain
        self.cathegory = cathegory
    }
}
