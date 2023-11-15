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
                            NavigationLink(destination: MealDetailView(meal: meal)) {
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
        .environment(\.colorScheme, settingsViewModel.colorScheme) // Apply the color scheme here
    }
}


struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search Desserts"
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
}
