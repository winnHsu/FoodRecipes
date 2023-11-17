//
//  HistoryViewModel.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/15/23.
//

import Foundation
import Combine
import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var events: [LikeEvent] = []
    
    func recordEvent(mealId: String, mealName: String, isLiked: Bool) {
        let event = LikeEvent(mealId: mealId, mealName: mealName, isLiked: isLiked, timestamp: Date())
        events.append(event)
        events.sort { $0.timestamp > $1.timestamp }
    }
}
