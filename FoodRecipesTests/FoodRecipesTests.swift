//
//  FoodRecipesTests.swift
//  FoodRecipesTests
//
//  Created by Winn Hsu on 11/17/23.
//

import XCTest
@testable import FoodRecipes

final class FoodRecipesTests: XCTestCase {

    func testMealDecoding() throws {
        let jsonData = """
        {
            "idMeal": "52899",
            "strMeal": "Dundee cake",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/wxyvqq1511723401.jpg",
            "strInstructions": "Put the almonds into a small bowl...",
            "strIngredient1": "Almonds",
            "strMeasure1": "100g",
            "strIngredient2": "Butter",
            "strMeasure2": "180g",
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let meal = try decoder.decode(Meal.self, from: jsonData)

        XCTAssertEqual(meal.idMeal, "52899")
        XCTAssertEqual(meal.strMeal, "Dundee cake")
        XCTAssertEqual(meal.ingredients.count, 2)
        XCTAssertEqual(meal.ingredients.first, "Almonds")
        XCTAssertEqual(meal.measurements.first, "100g")
    }

    func testMealsViewModel() throws {
        let viewModel = MealsViewModel()
        viewModel.fetchMeals()

        let expectation = XCTestExpectation(description: "Fetch meals")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(viewModel.meals.isEmpty, "Meals should not be empty after fetching.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMealsViewModelFetch() {
        let viewModel = MealsViewModel()

        viewModel.fetchMeals()

        let expectation = XCTestExpectation(description: "Fetch meals")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(viewModel.meals.isEmpty, "Meals should be fetched")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFavoriteUnfavoriteLogic() {
        let viewModel = FavoritesViewModel()
        let mealID = "52899"

        XCTAssertFalse(viewModel.isFavorite(mealId: mealID), "Meal should not be favorite initially.")

        viewModel.toggleFavorite(mealId: mealID)
        XCTAssertTrue(viewModel.isFavorite(mealId: mealID), "Meal should be favorite after toggling.")

        viewModel.toggleFavorite(mealId: mealID)
        XCTAssertFalse(viewModel.isFavorite(mealId: mealID), "Meal should not be favorite after toggling again.")
    }
}
