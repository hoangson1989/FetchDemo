//
//  MealDetail+Mapping.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Foundation

extension MealDetail {
    init(from mealDetailDB: MealDetailDB) {
        self.idMeal = mealDetailDB.idMeal!
        self.strMeal = mealDetailDB.strMeal!
        self.strInstructions = mealDetailDB.strInstructions!
        self.strMealThumb = mealDetailDB.strMealThumb
        
        self.strDrinkAlternate = mealDetailDB.strDrinkAlternate
        self.strCategory = mealDetailDB.strCategory
        self.strArea = mealDetailDB.strArea
        self.strTags = mealDetailDB.strTags
        self.strYoutube = mealDetailDB.strYoutube
        self.strSource = mealDetailDB.strSource
        self.strImageSource = mealDetailDB.strImageSource
        self.strCreativeCommonsConfirmed = mealDetailDB.strCreativeCommonsConfirmed
        self.dateModified = mealDetailDB.dateModified
        
        if let data = mealDetailDB.strIngredient {
            self.strIngredient = try? JSONSerialization.jsonObject(with: data) as? [String : String]
        } else {
            self.strIngredient = nil
        }
        
        
        if let data = mealDetailDB.strMeasure {
            self.strMeasure = try? JSONSerialization.jsonObject(with: data) as? [String : String]
        } else {
            self.strMeasure = nil
        }
    }
}
