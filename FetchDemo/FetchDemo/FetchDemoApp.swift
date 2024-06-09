//
//  FetchDemoApp.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import SwiftUI

@main
struct FetchDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MealsView()
        }
    }
}
