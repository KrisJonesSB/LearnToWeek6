//
//  RecentsTableViewController.swift
//  LearnToiOS-Lesson4
//
//  Created by Mike Robinson on 02/06/2018.
//  Copyright © 2018 Mike Robinson. All rights reserved.
//

import UIKit

class RecentsTableViewController: ViewController {
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let recentCount = modelController.recentItemCount
    if recentCount == 0, presentedViewController == nil {
      let alert = UIAlertController(title: "Information",
                                    message: "You have not looked at any repos recently",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK",
                                    style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
    }
    return recentCount
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let recentIndexPath = modelController.recentItemsIndexPath(for: indexPath)
    
    return super.tableView(tableView, cellForRowAt: recentIndexPath)
    
  }
}
