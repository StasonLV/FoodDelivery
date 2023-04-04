//
//  MenuTabDTO.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import Foundation

//объект для дата трансфера приходящего массива
struct MenuTabDTO: Codable {
    let type: String?
    let menuItems: [MenuItem]?
}

struct MenuItem: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let restaurantChain: String?
}
