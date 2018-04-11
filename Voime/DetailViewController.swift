//
//  DetailViewController.swift
//  Selfie
//
//  Created by Subhransu Behera on 12/10/14.
//  Copyright (c) 2014 subhb.org. All rights reserved.
//

import UIKit

protocol SelfieEditDelegate {
  func deleteSelfieObjectFromList(_ selfieImgObject: SelfieImage)
}

class DetailViewController: UIViewController {
  @IBOutlet weak var detailTitleLbl: UILabel!
  @IBOutlet weak var detailThumbImgView: UIImageView!
  @IBOutlet weak var activityIndicatorView: UIView!
  
  var editDelegate:SelfieEditDelegate! = nil
  var selfieCustomObj : SelfieImage! = nil
  let httpHelper = HTTPHelper()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func displayAlertMessage(_ alertTitle:String, alertDescription:String) -> Void {
    // hide activityIndicator view and display alert message
    self.activityIndicatorView.isHidden = true
    let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
    errorAlert.show()
  }
  
  @IBAction func deleteBtnTapped(_ sender: AnyObject) {
  }
}
