//
//  MealOverviewView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/17/23.
//

import Foundation
import SwiftUI

struct MealOverviewView: View {
    let meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let instructions = meal.strInstructions {
                Text("Instructions")
                    .font(.headline)
                Text(instructions)
            }

            Text("Ingredients")
                .font(.headline)

            ForEach(Array(zip(meal.ingredients, meal.measurements)), id: \.0) { ingredient, measurement in
                HStack {
                    Text(ingredient)
                    Spacer()
                    Text(measurement)
                }
            }
        }
    }
}
