//
//  ImageDownloader.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 27/07/23.
//

import Foundation
import UIKit

class ImageDownloader {
    func downloadImage(with url: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = url, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard error == nil,
                  let data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async{
                completion(image)
            }
        }).resume()
    }
}
