//
//  ModelController.swift
//  LearnToiOS-Lesson4
//
//  Created by Mike Robinson on 31/05/2018.
//  Copyright © 2018 Mike Robinson. All rights reserved.
//

import UIKit

class ModelController: NSObject {

  static var shared = ModelController()

  private override init() {
    NSLog("ModelController is up and running")
  }
  
  var items: [[AnyHashable: Any]] = []
  
  var itemCount: Int {
    return self.items.count
  }
  
  private func item(at row: Int) -> [AnyHashable: Any] {
    return self.items[row]
  }

  private func owner(of item: [AnyHashable: Any]) -> [AnyHashable: Any] {
    let owner = item["owner"] as! [AnyHashable: Any]
    return owner
  }
  
  func nameOfItem(at row: Int) -> String {
    let item = self.item(at: row)
    let name = item["name"] as! String
    
    return name
  }
  
  func descriptionOfItem(at row: Int) -> String {
    let item = self.item(at: row)
    let description = item["description"] as! String
    
    return description
  }
  
  func isPrivateItem(at row: Int) -> Bool {
    let item = self.item(at: row)
    let isPrivate = item["private"] as! Bool
    
    return isPrivate
  }
  
  func urlStringOfItem(at row: Int) -> String {
    let item = self.item(at: row)
    let urlString = item["url"] as! String
    
    return urlString
  }

    func pageForItem(at row: Int) -> String {
        let item = self.item(at: row)
        let urlString = item["html_url"] as! String

        return urlString
    }
  
  func imageOfItem(at row: Int) -> UIImage? {
    let image: UIImage?
    
    let item = self.item(at: row)
    let owner = self.owner(of: item)
    if let avatarImageUrlString = owner["avatar_url"] as? String,
      let avatarImageUrl = URL(string: avatarImageUrlString),
      let imageData = try? Data(contentsOf: avatarImageUrl),
      let downloadedImage = UIImage(data: imageData) {
      
      image = downloadedImage
    }
    else {
      image = nil
    }
    return image
  }
  
  func loadAvatarImageOfItem(at row: Int, completion: @escaping (UIImage, Int) -> Void) {
    let item = self.item(at: row)
    let owner = self.owner(of: item)
    let avatarImageUrlString = owner["avatar_url"] as! String
    
    let avatarImageUrl = URL(string: avatarImageUrlString)!
    let task = URLSession.shared.dataTask(with: avatarImageUrl) { (optionalData, optionalResponse, optionalError) in
      if let error = optionalError {
        NSLog("\(error)")
      } else if let data = optionalData {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            completion(image, row)
          }
        } else {
          NSLog("Data was not an image :(")
        }
      } else if let response = optionalResponse {
        NSLog("No image but response was \(response)")
      } else {
        NSLog("Herp de derp")
      }
    }
    
    task.resume()
  }
  
  // MARK: Recents
  private var recents = [Int]()
  
  var recentItemCount: Int {
    return self.recents.count
  }
  
  func recentItem(at row: Int) -> Int {
    return self.recents[row]
  }
  
  func recentItemsIndexPath(for indexPath: IndexPath) -> IndexPath {
    let rowNumber = self.recentItem(at: indexPath.row)
    let recentIndexPath = IndexPath(row: rowNumber, section: indexPath.section)
    
    return recentIndexPath
  }
  
  func addRecent(for row: Int) {
    if let index = recents.index(of: row) {
      self.recents.remove(at: index)
    }
    self.recents.insert(row, at: 0)
  }
  
}
