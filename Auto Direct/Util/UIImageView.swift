//
//  UIImageView.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/29/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
        
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        let url = URL(string: link)
        do {
            let data = try Data(contentsOf: url!)
            self.image = UIImage(data: data)
        } catch {
            self.image = UIImage(named: "call")
        }
        
        
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            print(data)
            print(response)
            print(error)
            if error == nil {
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() { [weak self] in
                    self?.image = UIImage(data: data!)
                }
            } else {
                self.image = UIImage(named: "call")
            }
            
        }
    }
}
