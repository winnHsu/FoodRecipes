//
//  APIService.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/17/23.
//

import Combine
import Foundation

class APIService {
    static func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
