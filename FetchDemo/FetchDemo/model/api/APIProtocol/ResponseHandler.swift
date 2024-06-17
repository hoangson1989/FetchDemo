//
//  ResponseHandler.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/17/24.
//

import Foundation

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data : Data) throws -> ResponseDataType
}

extension ResponseHandler {
    func parseResponse<T: Response>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

typealias APIHandler = RequestHandler & ResponseHandler
