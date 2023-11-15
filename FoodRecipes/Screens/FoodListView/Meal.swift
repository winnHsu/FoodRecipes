//
//  Meal.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//
import Foundation

struct Meal: Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String?
    var ingredients: [String] = []
    var measurements: [String] = []

    var id: String {
        idMeal
    }
    
    init?(dictionary: [String: Any]) {
        guard let idMeal = dictionary["idMeal"] as? String,
              let strMeal = dictionary["strMeal"] as? String,
              let strMealThumb = dictionary["strMealThumb"] as? String else {
            return nil
        }
        
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strInstructions = dictionary["strInstructions"] as? String
        
        for i in 1...20 {
            if let ingredient = dictionary["strIngredient\(i)"] as? String, !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.ingredients.append(ingredient)
            }
            if let measurement = dictionary["strMeasure\(i)"] as? String, !measurement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.measurements.append(measurement)
            }
        }
    }
}

