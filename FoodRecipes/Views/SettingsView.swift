//
//  SettingsView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/15/23.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var settingsViewModel: SettingsViewModel

    var body: some View {
        List {
            Section(header: Text("Appearance")) {
                Picker("Theme", selection: $settingsViewModel.colorScheme) {
                    Text("Light").tag(ColorScheme.light)
                    Text("Dark").tag(ColorScheme.dark)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("More")) {
                Button(action: {
                    openURL(URL(string: "https://www.linkedin.com/in/winn-hsu/")!)
                }) {
                    HStack {
                        Text("Visit Developer")
                        Spacer()
                        Image(systemName: "arrow.up.right.square")
                    }
                }
                
                Button(action: {
                    openURL(URL(string: "https://github.com/winnHsu/FoodRecipes")!)
                }) {
                    HStack {
                        Text("View Repository")
                        Spacer()
                        Image(systemName: "arrow.up.right.square")
                    }
                }
            }
            
            Section {
                Text("App Info")
                Text("This app is designed as part of the coding challenge for the Fetch iOS Apprenticeship program. It showcases the ability to browse and discover dessert recipes using TheMealDB API. Here, users can explore meals sorted alphabetically, view detailed instructions, and learn ingredient measurements. Key features include a search function for easy recipe discovery, a favorites system to bookmark recipes, a theme toggle for light/dark mode preferences, and a history log recording like events with timestamps. The app embraces clean UI/UX principles, ensuring a user-friendly experience, and is developed with SwiftUI. This project embodies a commitment to modern iOS development practices and is a testament to growth and learning in mobile software engineering.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .navigationBarTitle("Settings", displayMode: .large)
    }
}
