//
//  Meal.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String?
    var ingredients: [String] = []
    var measurements: [String] = []

    var id: String {
        idMeal
    }

    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strMealThumb, strInstructions
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)

        let otherContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for i in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)")
            let measurementKey = DynamicCodingKeys(stringValue: "strMeasure\(i)")
            
            if let ingredientKey = ingredientKey, let ingredient = try otherContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                ingredients.append(ingredient)
            }

            if let measurementKey = measurementKey, let measurement = try otherContainer.decodeIfPresent(String.self, forKey: measurementKey),
               !measurement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                measurements.append(measurement)
            }
        }
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { nil }
        init?(intValue: Int) { nil }
    }
}
