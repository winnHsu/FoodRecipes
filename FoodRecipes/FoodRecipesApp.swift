//
//  FoodRecipesApp.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/14/23.
//

import SwiftUI

@main
struct FoodRecipesApp: App {
    @StateObject var favoritesViewModel = FavoritesViewModel()
    @StateObject var historyViewModel = HistoryViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()

    var body: some Scene {
        WindowGroup {
            FoodTabView()
                .environmentObject(favoritesViewModel)
                .environmentObject(historyViewModel)
                .environmentObject(settingsViewModel)
        }
    }
}


struct Previews_FoodRecipesApp_Previews: PreviewProvider {
    static var previews: some View {
        FoodTabView()
    }
}
