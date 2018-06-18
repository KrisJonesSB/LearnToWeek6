//
//  AvatarViewController.swift
//  LearnToiOS-Lesson4
//
//  Created by Mike Robinson on 02/06/2018.
//  Copyright © 2018 Mike Robinson. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController {

  var selectedIndexPath: IndexPath?
  let modelController = ModelController.shared
  
  @IBOutlet weak var avatarImageView: UIImageView!
  
  private var previousTransform = CGAffineTransform.identity
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    if let row = selectedIndexPath?.row {
      modelController.loadAvatarImageOfItem(at: row) { image, _ in
        self.avatarImageView.image = image
      }
    }
  }
  
  @IBAction func didRecogniseSwipe(_ sender: UISwipeGestureRecognizer) {
    NSLog("\(#function)")
    
    
    self.dismiss(animated: true) { }
    
  }
  
  @IBAction func didRecognisePinch(_ sender: UIPinchGestureRecognizer) {
    NSLog("\(#function): \(sender.scale)")
    
    let newTransform = previousTransform.scaledBy(x: sender.scale, y: sender.scale)

    self.avatarImageView.transform = newTransform

    previousTransform = newTransform
    
    sender.scale = 1

  }
  
  
  @IBAction func didRecogniseRotation(_ sender: UIRotationGestureRecognizer) {
    NSLog("\(#function): \(sender.rotation)")

    let newRotation = previousTransform.rotated(by: sender.rotation)
    self.avatarImageView.transform = newRotation
    
    previousTransform = newRotation
    
    sender.rotation = 0

  }
  
  @IBAction func didRecogniseLongPress(_ sender: UILongPressGestureRecognizer) {
    NSLog("\(#function)")
    
    let newCenter = sender.location(ofTouch: 0, in: self.view)
    
    self.avatarImageView.center = newCenter

  }
  
}

extension AvatarViewController: UIGestureRecognizerDelegate {
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
