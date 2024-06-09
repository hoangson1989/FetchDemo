//
//  Meal.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    var id : String {idMeal}
    
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
}
