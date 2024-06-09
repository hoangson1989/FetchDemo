//
//  ImageCache.swift
//  FetchDemo
//
//  Created by Sonny Truong on 6/8/24.
//

import Foundation
import SwiftUI
import UIKit

class ImageCache {
    static let shared = ImageCache()

    private var cache: [String: UIImage] = [:]

    func getImage(forKey key: String) -> UIImage? {
        return cache[key]
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache[key] = image
    }
}
