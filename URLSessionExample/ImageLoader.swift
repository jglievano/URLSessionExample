//
//  ImageLoader.swift
//  URLSessionExample
//
//  Created by Gabriel Lievano on 11/3/16.
//  Copyright © 2016 Juan Gabriel Lievano. All rights reserved.
//

import Foundation
import UIKit

// ImageLoader is best used as a singleton. You may however want to manage your own
// instance. To do so:
//   let loader = ImageLoader()
// And then use `loader` instead of `ImageLoader.shared`.
class ImageLoader {
  
  // This is a property that returns the ImageLoader singleton.
  // Usage (to download an image):
  //   ImageLoader.shared.downloadImage(...)
  static let shared = ImageLoader()
  
  // This a property that returns the amount of images downloaded. Is not needed but makes code a
  // bit cleaner.
  var size: Int {
    get {
      return images.count
    }
  }
  
  // Initializes an empty array with items of type UIImage.
  var images: [UIImage] = [UIImage]()
  
  func downloadImage(path: String, completionHandler: @escaping () -> ()) {
    let url = URL(string: path)!
    URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      // If error is equal to nil it means request was successful.
      if error == nil {
        // We add the downloaded image to the images array.
        let img = UIImage(data: data!)!
        self.images.append(img)
      }
      // We then call our completionHandler to let know `images` is updated.
      // We automatically perform its execution on the main queue (a.k.a. UI thread).
      DispatchQueue.main.async(execute: completionHandler)
    }.resume() // Remember to call resume()!
  }
}
