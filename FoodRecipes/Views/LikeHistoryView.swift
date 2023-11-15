//
//  LikeHistoryView.swift
//  FoodRecipes
//
//  Created by Winn Hsu on 11/15/23.
//

import Foundation
import SwiftUI

struct LikeHistoryView: View {
    @EnvironmentObject var historyViewModel: HistoryViewModel
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        List {
            ForEach(historyViewModel.events) { event in
                VStack(alignment: .leading) {
                    Text(event.mealName)
                        .font(.headline)
                    
                    HStack {
                        Text(event.isLiked ? "Liked" : "Unliked")
                        Spacer()
                        Text("\(dateFormatter.string(from: event.timestamp))")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
            }
        }
        .navigationBarTitle("Like History")
    }
}
