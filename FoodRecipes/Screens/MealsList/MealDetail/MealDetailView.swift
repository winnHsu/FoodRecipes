//
//  MealDetailView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import SwiftUI
import Combine

struct MealDetailView: View {
    @State private var isFavorite: Bool
    @State private var selectedTab: Int = 0
    @State private var mealDetails: Meal?
    @State private var cancellables = Set<AnyCancellable>()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var historyViewModel: HistoryViewModel
    let meal: Meal
    
    init(meal: Meal, favoritesViewModel: FavoritesViewModel) {
        self.meal = meal
        self._isFavorite = State(initialValue: favoritesViewModel.isFavorite(mealId: meal.idMeal))
    }

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                 AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                     image.resizable()
                 } placeholder: {
                     Color.gray.opacity(0.3)
                 }
                 .aspectRatio(contentMode: .fill)
                 .frame(height: 300)
                 .clipped()

                 Button(action: {
                     isFavorite.toggle()
                     favoritesViewModel.toggleFavorite(mealId: meal.idMeal)
                     historyViewModel.recordEvent(mealId: meal.idMeal, mealName: meal.strMeal, isLiked: isFavorite)
                 }) {
                     Image(systemName: isFavorite ? "heart.fill" : "heart")
                         .foregroundColor(isFavorite ? .red : .gray)
                         .padding()
                         .background(Color.white.opacity(0.6))
                         .clipShape(Circle())
                         .padding([.trailing, .top], 10)
                 }
             }
             
             Text(meal.strMeal)
                 .font(.title)
                 .fontWeight(.bold)

            if let detailedMeal = mealDetails {
                Text(detailedMeal.strMeal)
                    .font(.title)
                    .fontWeight(.bold)

                Picker("Select", selection: $selectedTab) {
                    Text("Overview").tag(0)
                    Text("Instruction").tag(1)
                    Text("More").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Divider()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        switch selectedTab {
                        case 0:
                            MealOverviewView(meal: detailedMeal)
                        case 1:
                            MealInstructionsView(meal: detailedMeal)
                        case 2:
                            MealIngredientsView(meal: detailedMeal)
                        default:
                            EmptyView()
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                }
            } else {
                Text("Loading...")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchMealDetails()
        }
    }
    
    private func fetchMealDetails() {
        guard let url = URL(string: Endpoints.mealDetails(forID: meal.idMeal)) else { return }

        APIService.fetch(url: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { (response: MealDetailResponse) in
                self.mealDetails = response.meals.first
            })
            .store(in: &cancellables)
    }
}
