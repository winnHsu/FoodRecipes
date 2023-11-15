//
//  MealDetailView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//
import SwiftUI

struct MealDetailView: View {
    @State private var isFavorite: Bool = false
    @State private var selectedTab: Int = 0
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var historyViewModel: HistoryViewModel
    let meal: Meal

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

            // Tab bar section
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
                    // Display the content based on the selected tab
                    Group {
                        switch selectedTab {
                        case 0:
                            // Overview content
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
                        case 1:
                            // Instruction content
                            VStack(alignment: .leading) {
                                Text("Instructions")
                                    .font(.headline)
                                Text(meal.strInstructions ?? "")
                            }
                        case 2:
                            // Ingredient/Measurement content
                            VStack(alignment: .leading) {
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
                        default:
                            EmptyView()
                        }
                    }
                    .padding([.leading, .trailing, .bottom])

                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
