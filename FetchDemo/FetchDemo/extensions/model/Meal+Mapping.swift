//
//  Meal+Mapping.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Foundation

extension Meal {
    init(from mealDB: MealDB) {
        self.idMeal = mealDB.idMeal!
        self.strMeal = mealDB.strMeal!
        self.strMealThumb = mealDB.strMealThumb
    }
}
