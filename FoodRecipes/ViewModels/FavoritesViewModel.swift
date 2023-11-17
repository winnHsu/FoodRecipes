//
//  FavoritesViewModel.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import SwiftUI
import Combine
import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favorites: Set<String> = []
    @Published var history: [FavoriteEvent] = []

    func toggleFavorite(mealId: String) {
        if favorites.contains(mealId) {
            favorites.remove(mealId)
            addEvent(mealId: mealId, action: .unlike)
        } else {
            favorites.insert(mealId)
            addEvent(mealId: mealId, action: .like)
        }
    }

    private func addEvent(mealId: String, action: FavoriteAction) {
        let event = FavoriteEvent(mealId: mealId, action: action, timestamp: Date())
        history.append(event)
    }

    func isFavorite(mealId: String) -> Bool {
        favorites.contains(mealId)
    }
}

struct FavoriteEvent {
    let mealId: String
    let action: FavoriteAction
    let timestamp: Date
}

enum FavoriteAction: String {
    case like = "Liked"
    case unlike = "Unliked"
}
