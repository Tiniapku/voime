//
//  SelfieCollectionViewController.swift
//  Selfie
//
//  Created by Behera, Subhransu on 29/8/14.
//  Copyright (c) 2014 subhb.org. All rights reserved.
//

import UIKit

let reuseIdentifier = "SelfieCollectionViewCell"

class SelfieCollectionViewController: UICollectionViewController {
  var shouldFetchNewData = true
  var dataArray = [SelfieImage]()
  let httpHelper = HTTPHelper()
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    let defaults = UserDefaults.standard
    
    if defaults.object(forKey: "userLoggedIn") == nil {
      if let loginController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
        self.navigationController?.present(loginController, animated: true, completion: nil)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setNavigationItems() {
    let logOutBtn = UIBarButtonItem(title: "logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SelfieCollectionViewController.logoutBtnTapped))
    self.navigationItem.leftBarButtonItem = logOutBtn
    
    let navCameraBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(SelfieCollectionViewController.cameraBtnTapped))
    self.navigationItem.rightBarButtonItem = navCameraBtn
  }
  
  // 1. Clears the NSUserDefaults flag
  func clearLoggedinFlagInUserDefaults() {
  }
  
  // 2. Removes the data array
  func clearDataArrayAndReloadCollectionView() {
  }
  
  // 3. Clears API Auth token from Keychain
  func clearAPITokensFromKeyChain () {    
  }
  
  @objc func logoutBtnTapped() {
  }
  
  @objc func cameraBtnTapped() {
    displayCameraControl()
  }
  
  func loadSelfieData () {    
  }
  
  func removeObject<T:Equatable>(_ arr:inout Array<T>, object:T) -> T? {
    return nil
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
    
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.dataArray.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SelfieCollectionViewCell
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
}

// Camera Extension

extension SelfieCollectionViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  func displayCameraControl() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
      imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
      
      if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front) {
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDevice.front
      } else {
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDevice.rear
      }
    } else {
      imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
    }
    
    self.present(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [AnyHashable: Any]) {
  }
}

// Compose Selfie Extension

extension SelfieCollectionViewController : SelfieComposeDelegate {
  func presentComposeViewControllerWithImage(_ image:UIImage!) {    
  }
  
  func reloadCollectionViewWithSelfie(_ selfieImgObject: SelfieImage) {
  }
}

// Selfie Details Extension

extension SelfieCollectionViewController : SelfieEditDelegate {
  func pushDetailsViewControllerWithSelfieObject(_ selfieRowObj:SelfieImage!) {
  }
  
  func deleteSelfieObjectFromList(_ selfieImgObject: SelfieImage) {    
  }
}
