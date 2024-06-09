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
        
        var strIngredient : [String : String]? = nil
        if let data = mealDetailDB.strIngredient {
            strIngredient = try? JSONSerialization.jsonObject(with: data) as? [String : String]
        }
        
        self.strIngredient1 = strIngredient?["strIngredient1"]
        self.strIngredient2 = strIngredient?["strIngredient2"]
        self.strIngredient3 = strIngredient?["strIngredient3"]
        self.strIngredient4 = strIngredient?["strIngredient4"]
        self.strIngredient5 = strIngredient?["strIngredient5"]
        self.strIngredient6 = strIngredient?["strIngredient6"]
        self.strIngredient7 = strIngredient?["strIngredient7"]
        self.strIngredient8 = strIngredient?["strIngredient8"]
        self.strIngredient9 = strIngredient?["strIngredient9"]
        self.strIngredient10 = strIngredient?["strIngredient10"]
        self.strIngredient11 = strIngredient?["strIngredient11"]
        self.strIngredient12 = strIngredient?["strIngredient12"]
        self.strIngredient13 = strIngredient?["strIngredient13"]
        self.strIngredient14 = strIngredient?["strIngredient14"]
        self.strIngredient15 = strIngredient?["strIngredient15"]
        self.strIngredient16 = strIngredient?["strIngredient16"]
        self.strIngredient17 = strIngredient?["strIngredient17"]
        self.strIngredient18 = strIngredient?["strIngredient18"]
        self.strIngredient19 = strIngredient?["strIngredient19"]
        self.strIngredient20 = strIngredient?["strIngredient20"]
        
        
        var strMeasure : [String : String]? = nil
        if let data = mealDetailDB.strMeasure {
            strMeasure = try? JSONSerialization.jsonObject(with: data) as? [String : String]
        }
        self.strMeasure1 = strMeasure?["strIngredient1"]
        self.strMeasure2 = strMeasure?["strIngredient2"]
        self.strMeasure3 = strMeasure?["strIngredient3"]
        self.strMeasure4 = strMeasure?["strIngredient4"]
        self.strMeasure5 = strMeasure?["strIngredient5"]
        self.strMeasure6 = strMeasure?["strIngredient6"]
        self.strMeasure7 = strMeasure?["strIngredient7"]
        self.strMeasure8 = strMeasure?["strIngredient8"]
        self.strMeasure9 = strMeasure?["strIngredient9"]
        self.strMeasure10 = strMeasure?["strIngredient10"]
        self.strMeasure11 = strMeasure?["strIngredient11"]
        self.strMeasure12 = strMeasure?["strIngredient12"]
        self.strMeasure13 = strMeasure?["strIngredient13"]
        self.strMeasure14 = strMeasure?["strIngredient14"]
        self.strMeasure15 = strMeasure?["strIngredient15"]
        self.strMeasure16 = strMeasure?["strIngredient16"]
        self.strMeasure17 = strMeasure?["strIngredient17"]
        self.strMeasure18 = strMeasure?["strIngredient18"]
        self.strMeasure19 = strMeasure?["strIngredient19"]
        self.strMeasure20 = strMeasure?["strIngredient20"]
    }
    
    func value(forKey key: String) -> String? {
        let mirror = Mirror(reflecting: self)
        return mirror.children.first { $0.label == key }?.value as? String
    }
}
