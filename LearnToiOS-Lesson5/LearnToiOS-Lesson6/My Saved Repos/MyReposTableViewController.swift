//
//  MyReposTableViewController.swift
//  LearnToiOS-Lesson6
//
//  Created by Kris Jones on 18/06/2018.
//  Copyright © 2018 LearnTo iOS. All rights reserved.
//

import UIKit
import CoreData

class MyReposTableViewController: UITableViewController {
  
  var myRepos = [Repo]()
  var coreDataStack = CoreDataStack.shared
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "My Saved Repos"
    populateTableView()
    
   
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  
  @IBAction func addButtonTap(_ sender: Any) {
    addRecord()
  }
  
  @IBAction func deleteButtonTap(_ sender: Any) {
    deleteAll()
  }
  
  // Temp Function
  func addRecord() {
    let repo = Repo(context: coreDataStack.viewContext)
    repo.name = "Test 1"
    repo.isPrivate = false
    try? coreDataStack.viewContext.save()
    populateTableView()
  }
  
  func populateTableView() {
    
    let request: NSFetchRequest<Repo> = Repo.fetchRequest()
    
    do {
      myRepos = try coreDataStack.viewContext.fetch(request)
      self.tableView.reloadData()
    } catch {
      print("There was an error...")
    }
  }
  
  func deleteAll() {
    
    let fetchRequest: NSFetchRequest<Repo> = Repo.fetchRequest()

    if let result = try? coreDataStack.viewContext.fetch(fetchRequest) {
      for object in result {
         coreDataStack.viewContext.delete(object)
      }
    }
    
    try? coreDataStack.viewContext.save()
    populateTableView()
  }
  
  func deleteRepo(with name: String) {
    
    let fetchRequest: NSFetchRequest<Repo> = Repo.fetchRequest()
    let predicate = NSPredicate(format: "name = \(name)")
    fetchRequest.predicate = predicate
    
    if let result = try? coreDataStack.viewContext.fetch(fetchRequest) {
      for object in result {
        coreDataStack.viewContext.delete(object)
      }
    }
    
    try? coreDataStack.viewContext.save()
    populateTableView()
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myRepos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

    let repo = myRepos[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "titleSubtitle", for: indexPath)
    cell.textLabel?.text = repo.name
    cell.detailTextLabel?.text = repo.isPrivate ? "Private" : "Public"
    
    return cell
  }
  
}
