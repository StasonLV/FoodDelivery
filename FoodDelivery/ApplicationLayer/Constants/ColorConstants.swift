//
//  ColorConstants.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

enum Colors {
    
    enum TabBarColors {
        static let tabBarTintColor = #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1)
        static let tabBarBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    enum CathegoryChipsColors {
        static let cathegorySelectedLabelTextColor = #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1)
        static let cathegorySelectedChipsColor =  #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1).withAlphaComponent(0.2)
        static let cathegoryNotSelectedLabelTextColor =  #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1).withAlphaComponent(0.4)
        static let cathegoryNotSelectedChipsColor = #colorLiteral(red: 0.9623988271, green: 0.9691058993, blue: 0.981377542, alpha: 1)
        static let cathegoryNotSelectedBorderColor =  #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1).withAlphaComponent(0.4).cgColor
    }
    
    enum PriceViewColors {
        static let priceViewTextColor = #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1)
        static let priceViewBorderColor =  #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1).cgColor
    }
    
    enum CityBarItemColors {
        static let cityTextColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1921568627, alpha: 1)
    }
    
    enum MenuTableCellColors {
        static let descriptionTextColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6784313725, alpha: 1)
    }
}
