//
//  MealDetailViewModel.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Combine
import UIKit

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMealDetail(id: String) {
        isLoading = true
        MealAPIService.shared.fetchMealDetail(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { mealDetail in
                self.mealDetail = mealDetail
            })
            .store(in: &cancellables)
    }
}
