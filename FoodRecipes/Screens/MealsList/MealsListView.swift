//
//  MealsListView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import SwiftUI

struct MealsListView: View {
    @ObservedObject var viewModel = MealsViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var historyViewModel: HistoryViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 15)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(viewModel.searchResults) { meal in
                            NavigationLink(destination: MealDetailView(meal: meal, favoritesViewModel: favoritesViewModel)) {
                                MealCellView(meal: meal)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("Dessert Recipes")
            .navigationBarItems(trailing:
                HStack {
                    NavigationLink(destination: LikeHistoryView().environmentObject(historyViewModel)) {
                        Image(systemName: "bell.fill")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }

                    NavigationLink(destination: SettingsView().environmentObject(settingsViewModel)) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                }
            )
        }
        .onAppear {
            viewModel.fetchMeals()
        }
        .environment(\.colorScheme, settingsViewModel.colorScheme)
    }
}
