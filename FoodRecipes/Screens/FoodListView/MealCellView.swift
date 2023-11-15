//
//  MealCellView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import Foundation
import SwiftUI

import SwiftUI

struct MealCellView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var historyViewModel: HistoryViewModel
    @Environment(\.colorScheme) var colorScheme
    let meal: Meal

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .cornerRadius(8)
                
                Button(action: {
                    favoritesViewModel.toggleFavorite(mealId: meal.idMeal)
                    let isLiked = favoritesViewModel.isFavorite(mealId: meal.idMeal)
                    historyViewModel.recordEvent(mealId: meal.idMeal, mealName: meal.strMeal, isLiked: isLiked)
                }) {
                    Image(systemName: favoritesViewModel.isFavorite(mealId: meal.idMeal) ? "heart.fill" : "heart")
                        .foregroundColor(favoritesViewModel.isFavorite(mealId: meal.idMeal) ? .red : .gray)
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .clipShape(Circle())
                        .padding([.trailing, .top], 4)
                }
            }
            
            Text(meal.strMeal)
                .font(.headline)
                .lineLimit(1)
                .padding([.leading, .trailing, .bottom])
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
