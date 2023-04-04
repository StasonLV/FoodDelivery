//
//  MenuTabInteractor.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import Foundation

protocol FetchingLogic: AnyObject {
    func fetchImageData(
        _ string: String,
        completion: @escaping(Result<Data, Error>
        ) -> ())
    func fetchData(
        completion: @escaping (Result<[MenuTabEntity], Error>
        ) -> ())
}

protocol SavingAndLoadingOfflineLogic {
    func saveMenuArray(array: [MenuTabEntity])
    func loadMenuArray() -> [MenuTabEntity]
}

final class MenuTabInteractor {
    
    private let group = DispatchGroup()
    private let worker: NetworkWorker
    lazy var menuData = [MenuTabEntity]()
    private let savedMenuKey = "My key"
    private let defaults = UserDefaults.standard
    
    init(worker: NetworkWorker) {
        self.worker = worker
    }
}

//MARK: Saving And Loading Offline Logic
extension MenuTabInteractor: SavingAndLoadingOfflineLogic {
    func saveMenuArray(array: [MenuTabEntity]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            defaults.set(encoded, forKey: savedMenuKey)
            print(encoded)
        }
    }
    
    func loadMenuArray() -> [MenuTabEntity] {
        if let savedMenu = defaults.object(forKey: savedMenuKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedMenu = try? decoder.decode([MenuTabEntity].self, from: savedMenu) {
                menuData = loadedMenu
            }
        }
        return menuData
    }
}

//MARK: Fetching Logic
extension MenuTabInteractor: FetchingLogic {
    
    func fetchImageData(
        _ string: String,
        completion: @escaping(Result<Data, Error>
        ) -> ()) {
        worker.loadImageFrom(url: string, completion: completion)
    }
    
    func fetchData(completion: @escaping (Result<[MenuTabEntity], Error>) -> ()) {
        DispatchQueue.global(qos: .background).async {
            for cathegory in Cathegory.allCases {
                
                let cathegory = cathegory.rawValue
                
                self.group.enter()
                
                self.worker.loadMenu(cathegory: cathegory) { result in
                    switch result {
                        
                    case .success(let arr):
                        guard let arr = arr.menuItems else { return }
                        
                        let result = arr.compactMap { MenuTabEntity(model: $0, cathegory: cathegory) }
                        
                        completion(.success(result))
                        self.group.leave()
                    case .failure(let error):
                        completion(.failure(error))
                    }
                    self.group.wait()
                }
                self.group.wait()
            }
        }
    }
}

