//
//  LikeEvent.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/17/23.
//

import Foundation

struct LikeEvent: Identifiable {
    let id = UUID()
    let mealId: String
    let mealName: String
    let isLiked: Bool
    let timestamp: Date
}
