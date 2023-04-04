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

final class MenuTabInteractor {
    
    private let group = DispatchGroup()
    private let worker: NetworkWorker
    
    init(worker: NetworkWorker) {
        self.worker = worker
    }
}

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

