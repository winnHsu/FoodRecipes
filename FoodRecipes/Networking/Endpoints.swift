//
//  Endpoints.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/17/23.
//

import Foundation

struct Endpoints {
    static let mealsList = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static func mealDetails(forID id: String) -> String {
        return "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
    }
}
