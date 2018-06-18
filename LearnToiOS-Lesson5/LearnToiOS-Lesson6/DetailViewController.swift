//
//  DetailViewController.swift
//  LearnToiOS-Lesson4
//
//  Created by Mike Robinson on 04/06/2018.
//  Copyright © 2018 Mike Robinson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var selectedIndexPath: IndexPath?
  let modelController = ModelController.shared
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var urlLabel: UILabel!
  @IBOutlet weak var sourceTypeLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var gitHubButton: UIButton!

  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    if let indexPath = selectedIndexPath {
      let name = modelController.nameOfItem(at: indexPath.row)
      self.title = name
      self.titleLabel.text = name
      self.descriptionLabel.text = modelController.descriptionOfItem(at: indexPath.row)
      self.urlLabel.text = modelController.urlStringOfItem(at: indexPath.row)
      self.sourceTypeLabel.text = modelController.isPrivateItem(at: indexPath.row) ? "Closed Source" : " OpenSource"
      self.gitHubButton.titleLabel?.text = modelController.pageForItem(at: indexPath.row)
      
      modelController.loadAvatarImageOfItem(at: indexPath.row) { (image, _) in
        self.avatarImageView.image = image
      }
    }
  }
  
  @IBAction func didRecogniseTap(_ sender: UITapGestureRecognizer) {
    
    performSegue(withIdentifier: "showAvatar", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let destinationVC = segue.destination as? AvatarViewController {
      destinationVC.selectedIndexPath = selectedIndexPath
    }
    if let destinationVC = segue.destination as? WebViewController {
        guard let selectedIndexPathRow = selectedIndexPath?.row else { return }
        destinationVC.url = modelController.pageForItem(at: selectedIndexPathRow)
    }
  }
}
