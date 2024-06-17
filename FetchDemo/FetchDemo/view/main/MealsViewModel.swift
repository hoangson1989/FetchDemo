//
//  MealsViewModel.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//
import Combine
import UIKit

class MealsViewModel : ObservableObject {
    
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()
    

    func fetchDesserts() {
        guard !isLoading else { return }
        isLoading = true
        
        MealService.shared.fetchDesserts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { meals in
                self.meals = meals.filter { !$0.strMeal.isEmpty }
            })
            .store(in: &cancellables)
    }
}
