//
//  MealsView.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import SwiftUI
import CoreData

struct MealsView: View {
    @StateObject private var viewModel = MealsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.meals) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                            Text(meal.strMeal)
                        }
                    }
                    
                    Button("Refresh") {
                        viewModel.refreshDesserts()
                    }
                    .padding()
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                // Only fetch if the list is empty
                if viewModel.meals.isEmpty {
                    viewModel.fetchDesserts()
                }
            }
        }
    }
}
#Preview {
    MealsView()
}
