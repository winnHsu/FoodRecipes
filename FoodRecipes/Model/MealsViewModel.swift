//
//  MealsViewModel.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import Foundation
import Combine

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var searchText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    // Search results based on the search text
    var searchResults: [Meal] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
        }
    }

    init() {
        fetchMeals()
                $searchText
            .receive(on: RunLoop.main)
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    func fetchMeals() {
            let listUrl = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
            
            URLSession.shared.dataTask(with: listUrl) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let mealsArray = json["meals"] as? [[String: Any]] {
                        // Extract meal IDs and fetch details for each meal
                        let mealIDs = mealsArray.compactMap { $0["idMeal"] as? String }
                        self?.fetchMealDetails(mealIDs: mealIDs)
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }.resume()
        }
        
        private func fetchMealDetails(mealIDs: [String]) {
            let group = DispatchGroup()
            
            var detailedMeals = [Meal]()
            
            for id in mealIDs {
                group.enter()
                let detailUrl = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
                
                URLSession.shared.dataTask(with: detailUrl) { data, response, error in
                    guard let data = data, error == nil else {
                        print("No data in response for meal ID \(id): \(error?.localizedDescription ?? "Unknown error")")
                        group.leave()
                        return
                    }
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let mealsResponse = MealsResponse(json: json) {
                            detailedMeals.append(contentsOf: mealsResponse.meals)
                        } else {
                            print("Could not parse the JSON for meal ID \(id).")
                        }
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                    
                    group.leave()
                }.resume()
            }
            
            group.notify(queue: .main) { [weak self] in
                self?.meals = detailedMeals.sorted { $0.strMeal < $1.strMeal }
            }
        }
}
