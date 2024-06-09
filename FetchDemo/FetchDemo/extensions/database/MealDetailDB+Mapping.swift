//
//  MealDetailDB+Mapping.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Foundation

extension MealDetailDB {
    func update(from mealDetail: MealDetail) {
        self.idMeal = mealDetail.idMeal
        self.strMeal = mealDetail.strMeal
        self.strInstructions = mealDetail.strInstructions
        self.strMealThumb = mealDetail.strMealThumb
        
        self.strDrinkAlternate = mealDetail.strDrinkAlternate
        self.strCategory = mealDetail.strCategory
        self.strArea = mealDetail.strArea
        self.strTags = mealDetail.strTags
        self.strYoutube = mealDetail.strYoutube
        self.strSource = mealDetail.strSource
        self.strImageSource = mealDetail.strImageSource
        self.strCreativeCommonsConfirmed = mealDetail.strCreativeCommonsConfirmed
        self.dateModified = mealDetail.dateModified
        
        
        var ingredientDict: [String: String] = [:]
        var measureDict: [String: String] = [:]
        
        let mirror = Mirror(reflecting: mealDetail)
        for child in mirror.children {
            if let label = child.label, let value = child.value as? String {
                if label.starts(with: "strIngredient") {
                    ingredientDict[label] = value
                } else if label.starts(with: "strMeasure") {
                    measureDict[label] = value
                }
            }
        }
        
        if let ingredientData = try? JSONSerialization.data(withJSONObject: ingredientDict) {
            self.strIngredient = ingredientData
        }
        
        if let measureData = try? JSONSerialization.data(withJSONObject: measureDict) {
            self.strMeasure = measureData
        }
    }
}
