//
//  ApiMealDetail.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/17/24.
//

import Foundation

extension FetchAPIs.GetMealDetail : APIHandler {
    
    var path: String {
        "/api/json/v1/1/lookup.php"
    }

    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "i", value: mealID)]
    }
    
    typealias ResponseDataType = MealDetailResponse
}
