//
//  TableHeaderView.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

final class TableHeaderView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        clipsToBounds = true
        layer.cornerRadius = 25
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
