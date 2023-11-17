//
//  MealsResponse.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import Foundation

struct MealsResponse: Decodable {
    let meals: [Meal]
}

struct MealDetailResponse: Decodable {
    let meals: [Meal]
}
