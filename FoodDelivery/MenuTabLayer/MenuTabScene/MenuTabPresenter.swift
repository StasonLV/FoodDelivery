//
//  MenuTabPresenter.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import Foundation

protocol PresentationLogic: AnyObject {
    var numberOfRowsInSection: Int { get }
    var sections: [ListSections] { get set }
    func didScroll(_ y: CGFloat)
    func getFoodByIndex(_ index: Int) -> MenuTabEntity
    func didSelectCathegory(_ string: String)
    func loadImageData(_ string: String, completion: @escaping (Data) -> ())
    func onViewAttached(controller: MenuTabController)
}

protocol OnAppDisnissLogic {
    func saveMenuArray()
}

final class MenuTabPresenter {
    
    private let interactor: MenuTabInteractor
    private weak var controller: MenuTabController?
    
    private var scrollFlag = false
    
    var sections: [ListSections] = [.ads,
                                    .cathegory(Cathegory.allCases)]
    
    private var foodArray: [MenuTabEntity] = []
    
    init(interactor: MenuTabInteractor) {
        self.interactor = interactor
    }
}

//MARK: Presentation Logic
extension MenuTabPresenter: PresentationLogic {
    
    var numberOfRowsInSection: Int {
        get {
            foodArray.count
        }
    }
    
    func didScroll(_ y: CGFloat) {
        if y > 0 && scrollFlag == false {
            scrollFlag = true
            controller?.didScroll(state: .up)
        }
        
        if y < 0 && scrollFlag == true {
            scrollFlag = false
            controller?.didScroll(state: .down)
        }
    }
    
    func getFoodByIndex(_ index: Int) -> MenuTabEntity {
        foodArray[index]
    }
    
    func didSelectCathegory(_ string: String) {
        guard let row = foodArray.firstIndex(where: { $0.cathegory == string }) else { return }
        
        controller?.scrollTo(row: row, section: 0)
    }
    
    func loadImageData(_ string: String, completion: @escaping (Data) -> ()) {
        interactor.fetchImageData(string) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(data)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func onViewAttached(controller: MenuTabController) {
        self.controller = controller
        fetchData()
    }
}

//MARK: On App Dismiss Logic
extension MenuTabPresenter: OnAppDisnissLogic {
    func saveMenuArray() {
        interactor.saveMenuArray(array: self.foodArray)
    }
}

//MARK: Методы отображения
private extension MenuTabPresenter {
    
    func fetchData() {
        interactor.fetchData { [ weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let array):
                self.foodArray.append(contentsOf: array)
                
                DispatchQueue.main.async {
                    self.controller?.reloadData()
                }
            case .failure( _):
                self.foodArray.append(contentsOf: self.interactor.loadMenuArray())
                DispatchQueue.main.async {
                    self.controller?.reloadData()
                    self.controller?.present(AppAlerts.connectionAlert, animated: true)
                }
            }
        }
    }
}
