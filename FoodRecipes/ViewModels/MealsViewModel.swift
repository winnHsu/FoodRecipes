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

    var searchResults: [Meal] {
        searchText.isEmpty ? meals : meals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
    }

    init() {
        fetchMeals()
        $searchText
            .receive(on: RunLoop.main)
            .sink { _ in self.objectWillChange.send() }
            .store(in: &cancellables)
    }

    func fetchMeals() {
        guard let url = URL(string: Endpoints.mealsList) else { return }

        APIService.fetch(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] (response: MealsResponse) in
                self?.meals = response.meals.sorted { $0.strMeal < $1.strMeal }
            })
            .store(in: &cancellables)
    }

}
