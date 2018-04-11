//
//  ComposeViewController.swift
//  Selfie
//
//  Created by Subhransu Behera on 12/10/14.
//  Copyright (c) 2014 subhb.org. All rights reserved.
//

import UIKit

protocol SelfieComposeDelegate {
  func reloadCollectionViewWithSelfie(_ selfieImgObject: SelfieImage)
}

class ComposeViewController: UIViewController {
  @IBOutlet weak var thumbImgView: UIImageView!
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var activityIndicatorView: UIView!
  
  var thumbImg : UIImage!
  var composeDelegate:SelfieComposeDelegate! = nil
  let httpHelper = HTTPHelper()
  
  override func viewDidLoad() {
    super.viewDidLoad()    
  }
  
  func setNavigationItems() {
    self.title = "Compose"
    
    let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComposeViewController.cancelBtnTapped))
    self.navigationItem.leftBarButtonItem = cancelBarButtonItem
    
    let postBarButtonItem = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComposeViewController.postBtnTapped))
    self.navigationItem.rightBarButtonItem = postBarButtonItem
  }
  
  func cancelBtnTapped() {
    self.dismiss(animated: true, completion: nil)
  }
  
  func displayAlertMessage(_ alertTitle:String, alertDescription:String) -> Void {
    // hide activityIndicator view and display alert message
    self.activityIndicatorView.isHidden = true
    let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
    errorAlert.show()
  }
  
  func postBtnTapped() {
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
