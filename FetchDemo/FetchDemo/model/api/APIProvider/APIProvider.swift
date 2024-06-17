//
//  APIProvider.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/17/24.
//

import Foundation
import Combine

protocol APIProvider {
    func requestPublisher<T: APIHandler>(for endpoint: T) -> Future<T.ResponseDataType,Error>
}


class APIAsyncProvider : APIProvider {
    func requestPublisher<T>(for endpoint: T) -> Future<T.ResponseDataType, Error> where T : RequestHandler, T : ResponseHandler {
        
        Future { promise in
            Task { [weak self] in
                do {
                    guard let self = self else {
                        throw ApiError(errorCode: "ERROR-3", message: "APIAsyncProvider dealloccated")
                    }
                    let request : URLRequest
                    do {
                        request = try endpoint.asUrlRequest()
                    } catch {
                        throw ApiError(errorCode: "ERROR-2", message: "Request invalid")
                    }
                    do {
                        let (data, _) = try await URLSession.shared.data(for: request)
                        let result = try endpoint.parseResponse(data: data)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }

}
