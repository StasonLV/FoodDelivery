//
//  Sections.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import Foundation

enum ListSections {
    case ads
    case cathegory([Cathegory])
    
    var count: Int {
        switch self {
        case .ads:
            return 10
        case .cathegory(let array):
            return array.count
        }
    }
}
