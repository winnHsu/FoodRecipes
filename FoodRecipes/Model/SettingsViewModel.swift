//
//  SettingsViewModel.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/15/23.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var colorScheme: ColorScheme = .light
    
    func toggleTheme() {
        colorScheme = colorScheme == .light ? .dark : .light
    }
}
