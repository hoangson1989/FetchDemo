//
//  MealDetail.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Foundation

struct MealDetail: Codable {
    var id: String { idMeal }

    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    let strIngredient: [String : String]?
    let strMeasure: [String : String]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        self.strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        self.strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        self.strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        self.strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        self.strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        self.strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        self.strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        self.dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
        
        
        var strIngredient = [String : String]()
        var strMeasure = [String : String]()
        for i in 1...20 {
            if let key = CodingKeys(stringValue: "strIngredient\(i)"), let val = try? container.decodeIfPresent(String.self, forKey: key) {
                strIngredient[key.stringValue] = val
            }
            if let key = CodingKeys(stringValue: "strMeasure\(i)"), let val = try? container.decodeIfPresent(String.self, forKey: key) {
                strMeasure[key.stringValue] = val
            }
        }
        self.strIngredient = strIngredient
        self.strMeasure = strMeasure
    }
}
