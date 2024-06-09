//
//  MealDB+Mapping.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Foundation

extension MealDB {
    func update(from meal: Meal) {
        self.idMeal = meal.idMeal
        self.strMeal = meal.strMeal
        self.strMealThumb = meal.strMealThumb
    }
}
