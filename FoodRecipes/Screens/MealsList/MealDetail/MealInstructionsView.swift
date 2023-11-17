//
//  MealInstructionsView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/17/23.
//

import Foundation
import SwiftUI

struct MealInstructionsView: View {
    let meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Instructions")
                .font(.headline)
            Text(meal.strInstructions ?? "")
        }
    }
}
