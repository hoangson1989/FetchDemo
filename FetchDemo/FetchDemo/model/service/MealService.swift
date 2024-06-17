//
//  MealAPIService.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Foundation
import Combine
import CoreData

class MealService {
    static let shared = MealService()
    private init(){}
        
    private let coreDataManager = PersistenceController.shared
    private let apiProvider : APIProvider = APIAsyncProvider()

    func fetchDesserts() -> AnyPublisher<[Meal], Error> {
        if NetworkMonitor.shared.isConnected {
            return fetchDessertsFromServer()
                .handleEvents(receiveOutput: { res in
                    self.saveMealsToCoreData(res.meals)
                })
                .map({$0.meals})
                .eraseToAnyPublisher()
        } else {
            return fetchDessertsFromCoreData()
        }        
    }
    
    func fetchMealDetail(id: String) -> AnyPublisher<MealDetail, Error> {
        if NetworkMonitor.shared.isConnected {
            return fetchMealDetailFromServer(id: id)
                .map({$0.meals.first!})
                .handleEvents(receiveOutput: { mealDetail in
                    self.saveMealDetailToCoreData(mealDetail)
                })
                .eraseToAnyPublisher()
        } else {
            return fetchMealDetailFromCoreData(id: id)
        }
    }
    //MARK: - Online Fetching
    private func fetchDessertsFromServer() -> AnyPublisher<MealResponse, Error> {
        let api = FetchAPIs.GetDesserts()
        return apiProvider.requestPublisher(for: api).eraseToAnyPublisher()
    }
    
    private func fetchMealDetailFromServer(id: String) -> AnyPublisher<MealDetailResponse, Error> {
        let api = FetchAPIs.GetMealDetail(mealID: id)
        return apiProvider.requestPublisher(for: api).eraseToAnyPublisher()
    }
    //MARK: - Offline Fetching
    private func fetchDessertsFromCoreData() -> AnyPublisher<[Meal], Error> {
        let context = coreDataManager.container.newBackgroundContext()
        let fetchRequest: NSFetchRequest<MealDB> = MealDB.fetchRequest()
        
        return Future { promise in
            context.perform {
                do {
                    let cdMeals = try context.fetch(fetchRequest)
                    let meals = cdMeals.map { Meal(from: $0) }
                    promise(.success(meals))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func fetchMealDetailFromCoreData(id: String) -> AnyPublisher<MealDetail, Error> {
        let context = coreDataManager.container.newBackgroundContext()
        let fetchRequest: NSFetchRequest<MealDetailDB> = MealDetailDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idMeal == %@", id)
        
        return Future { promise in
            context.perform {
                do {
                    if let cdMealDetail = try context.fetch(fetchRequest).first {
                        let mealDetail = MealDetail(from: cdMealDetail)
                        promise(.success(mealDetail))
                    } else {
                        promise(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    //MARK: - Caching
    private func saveMealsToCoreData(_ meals: [Meal]) {
        let context = coreDataManager.container.newBackgroundContext()
        context.perform {
            meals.forEach { meal in
                // Check if the meal already exists in Core Data
                let fetchRequest: NSFetchRequest<MealDB> = MealDB.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "idMeal == %@", meal.idMeal)
                
                do {
                    let existingMeal = try context.fetch(fetchRequest).first
                    if let existingMeal = existingMeal {
                        // Update the existing meal
                        existingMeal.update(from: meal)
                    } else {
                        // Create a new meal if it doesn't exist
                        let mealDB = MealDB(context: context)
                        mealDB.update(from: meal)
                    }
                } catch {
                    print("Error fetching meal from Core Data: \(error.localizedDescription)")
                }
            }
            
            // Save the context
            self.coreDataManager.saveContext(context)
        }
    }
    
    private func saveMealDetailToCoreData(_ mealDetail: MealDetail) {
        let context = coreDataManager.container.newBackgroundContext()
        context.perform {
            // Check if the meal detail already exists in Core Data
            let fetchRequest: NSFetchRequest<MealDetailDB> = MealDetailDB.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idMeal == %@", mealDetail.idMeal)
            
            do {
                let existingMealDetail = try context.fetch(fetchRequest).first
                if let existingMealDetail = existingMealDetail {
                    // Update the existing meal detail
                    existingMealDetail.update(from: mealDetail)
                } else {
                    // Create a new meal detail if it doesn't exist
                    let mealDetailDB = MealDetailDB(context: context)
                    mealDetailDB.update(from: mealDetail)
                }
            } catch {
                print("Error fetching meal detail from Core Data: \(error.localizedDescription)")
            }
            
            // Save the context
            self.coreDataManager.saveContext(context)
        }
    }
}
