//
//  MealsResponse.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import Foundation

struct MealsResponse {
    let meals: [Meal]
    
    init?(json: Any) {
        guard let jsonDictionary = json as? [String: Any],
              let mealsArray = jsonDictionary["meals"] as? [[String: Any]] else {
            return nil
        }
        
        self.meals = mealsArray.compactMap(Meal.init(dictionary:))
    }
}
