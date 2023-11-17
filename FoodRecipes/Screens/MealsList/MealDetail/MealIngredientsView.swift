//
//  MealIngredientsView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/17/23.
//

import Foundation
import SwiftUI

struct MealIngredientsView: View {
    let meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredients/Measurements")
                .font(.headline)
            ForEach(Array(zip(meal.ingredients.indices, meal.ingredients)), id: \.0) { index, ingredient in
                HStack {
                    Text(ingredient)
                    Spacer()
                    Text(meal.measurements.indices.contains(index) ? meal.measurements[index] : "")
                }
            }
        }
    }
}
