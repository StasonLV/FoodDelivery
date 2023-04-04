//
//  NetworkWorker.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import Foundation

protocol LoadingLogic: AnyObject {
    func loadMenu(
        cathegory: String,
        completion: @escaping (Result<MenuTabDTO, Error>
        )-> ())
    func loadImageFrom(
        url: String,
        completion: @escaping(Result<Data, Error>
        ) -> ())
}

final class NetworkWorker {
    
    private enum Api { static let key = "8b6a2bbe8e1542728115ebfcff7dce44" }
    private let baseUrl = "https://api.spoonacular.com/"
    private let session = URLSession.shared

}

extension NetworkWorker: LoadingLogic {
    
    func loadMenu(
        cathegory: String,
        completion: @escaping (Result<MenuTabDTO, Error>
        ) -> ()) {
        let api = baseUrl + "food/menuItems/search?query=" + "\(cathegory)" + "&number=10&apiKey=" + Api.key
        loadData(api: api, completion: completion)
    }
    
    func loadImageFrom(url: String,
                       completion: @escaping(Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        
        self.session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            completion(.success(data))
        }.resume()
    }
}

private extension NetworkWorker {
    
    func loadData<T: Decodable>(
        api: String,
        completion: @escaping (Result<T, Error>
        ) -> ()) {
        guard let url = URL(string: api) else { return }
        
        let request = URLRequest(url: url)
        
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            do {
                let newData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newData))
            }
            catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
