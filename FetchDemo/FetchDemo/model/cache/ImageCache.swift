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
    private let cache = NSCache<NSString, UIImage>()
    private let queue = DispatchQueue(label: "com.sonny.imagecache", attributes: .concurrent)
    
    static let shared = ImageCache()
    
    private init() {}
    
    func getImage(forKey key: String) -> UIImage? {
        var image: UIImage?
        queue.sync {
            image = cache.object(forKey: key as NSString)
        }
        return image
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        queue.async(flags: .barrier) {
            self.cache.setObject(image, forKey: key as NSString)
        }
    }
}
