//
//  Extensions.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String) {
        self.image = nil
        // Check for cached image
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            // do something with the image
            self.image = cachedImage
            return
        }
        // Create new image if image is not cached
        let url = URL(fileURLWithPath: urlString)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    // do something with the image
                    self.image = downloadedImage
                }
            }
        }
    }
}

/* UIColor extension */
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
