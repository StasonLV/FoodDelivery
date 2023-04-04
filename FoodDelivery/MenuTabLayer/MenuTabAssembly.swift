//
//  MenuControllerAssembly.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

enum MenuTabAssembly {
    
    static func build() -> UIViewController {
        
        let network = NetworkWorker()
        let interactor = MenuTabInteractor(worker: network)
        let presenter = MenuTabPresenter(interactor: interactor)
        let controller = MenuTabController(presenter: presenter)
        
        return controller
    }
}
