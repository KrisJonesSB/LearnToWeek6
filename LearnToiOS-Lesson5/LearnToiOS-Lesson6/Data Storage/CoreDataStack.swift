//
//  CoreDataStack.swift
//  LearnToiOS-Lesson5
//
//  Created by Kris Jones on 17/06/2018.
//  Copyright © 2018 LearnTo iOS. All rights reserved.
//

import CoreData

final class CoreDataStack {
  
  static let shared = CoreDataStack()
  var errorHandler: (Error) -> Void = {_ in }
  
  //#1
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Model")
    container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
      if let error = error {
        NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
        self?.errorHandler(error)
      }
    })
    return container
  }()
  
  //#2
  lazy var viewContext: NSManagedObjectContext = {
    return self.persistentContainer.viewContext
  }()
  
  //#3
  // Optional
  lazy var backgroundContext: NSManagedObjectContext = {
    return self.persistentContainer.newBackgroundContext()
  }()
  
  //#4
  func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
    self.viewContext.perform {
      block(self.viewContext)
    }
  }
  
  //#5
  func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
    self.persistentContainer.performBackgroundTask(block)
  }
}

