//
//  ViewController.swift
//  Selfie
//
//  Created by Behera, Subhransu on 29/8/14.
//  Copyright (c) 2014 subhb.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var signinBackgroundView: UIView!
  @IBOutlet weak var signupBackgroundView: UIView!
  @IBOutlet weak var signinEmailTextField: UITextField!
  @IBOutlet weak var signinPasswordTextField: UITextField!
  @IBOutlet weak var signupNameTextField: UITextField!
  @IBOutlet weak var signupEmailTextField: UITextField!
  @IBOutlet weak var signupPasswordTextField: UITextField!
  @IBOutlet weak var activityIndicatorView: UIView!
  @IBOutlet weak var passwordRevealBtn: UIButton!
  
  let httpHelper = HTTPHelper()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.activityIndicatorView.layer.cornerRadius = 10
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func passwordRevealBtnTapped(_ sender: AnyObject) {
    self.passwordRevealBtn.isSelected = !self.passwordRevealBtn.isSelected
    
    if self.passwordRevealBtn.isSelected {
      self.signupPasswordTextField.isSecureTextEntry = false
    }
      
    else {
      self.signupPasswordTextField.isSecureTextEntry = true
    }
  }
  
  func displaSigninView () {
    self.signinEmailTextField.text = nil
    self.signinPasswordTextField.text = nil

    if self.signupNameTextField.isFirstResponder {
      self.signupNameTextField.resignFirstResponder()
    }

    if self.signupEmailTextField.isFirstResponder {
      self.signupEmailTextField.resignFirstResponder()
    }

    if self.signupPasswordTextField.isFirstResponder {
      self.signupPasswordTextField.resignFirstResponder()
    }
    
    if self.signinBackgroundView.frame.origin.x != 0 {
      UIView.animate(withDuration: 0.8, animations: { () -> Void in
        self.signupBackgroundView.frame = CGRect(x: 320, y: 134, width: 320, height: 284)
        self.signinBackgroundView.alpha = 0.3
        
        self.signinBackgroundView.frame = CGRect(x: 0, y: 134, width: 320, height: 284)
        self.signinBackgroundView.alpha = 1.0
        }, completion: nil)
    }
  }
  
  func displaySignupView () {
    self.signupNameTextField.text = nil
    self.signupEmailTextField.text = nil
    self.signupPasswordTextField.text = nil

    if self.signinEmailTextField.isFirstResponder {
      self.signinEmailTextField.resignFirstResponder()
    }

    if self.signinPasswordTextField.isFirstResponder {
      self.signinPasswordTextField.resignFirstResponder()
    }
    
    if self.signupBackgroundView.frame.origin.x != 0 {
      UIView.animate(withDuration: 0.8, animations: { () -> Void in
        self.signinBackgroundView.frame = CGRect(x: -320, y: 134, width: 320, height: 284)
        self.signinBackgroundView.alpha = 0.3;
        
        self.signupBackgroundView.frame = CGRect(x: 0, y: 134, width: 320, height: 284)
        self.signupBackgroundView.alpha = 1.0
        
        }, completion: nil)
    }
  }
  
  func displayAlertMessage(_ alertTitle:String, alertDescription:String) -> Void {
    // hide activityIndicator view and display alert message
    self.activityIndicatorView.isHidden = true
    let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
    errorAlert.show()
  }
  
  @IBAction func createAccountBtnTapped(_ sender: AnyObject) {
    self.displaySignupView()
  }
  
  @IBAction func cancelBtnTapped(_ sender: AnyObject) {
    self.displaSigninView()
  }
  
  
  @IBAction func signupBtnTapped(_ sender: AnyObject) {
    // Code to hide the keyboards for text fields
    if self.signupNameTextField.isFirstResponder {
      self.signupNameTextField.resignFirstResponder()
    }
    
    if self.signupEmailTextField.isFirstResponder {
      self.signupEmailTextField.resignFirstResponder()
    }
    
    if self.signupPasswordTextField.isFirstResponder {
      self.signupPasswordTextField.resignFirstResponder()
    }
    self.activityIndicatorView.isHidden = false
    
  }
  
  @IBAction func signinBtnTapped(_ sender: AnyObject) {
    // resign the keyboard for text fields
    if self.signinEmailTextField.isFirstResponder {
      self.signinEmailTextField.resignFirstResponder()
    }
    
    if self.signinPasswordTextField.isFirstResponder {
      self.signinPasswordTextField.resignFirstResponder()
    }
  }
  
  func updateUserLoggedInFlag() {
  }
  
  func saveApiTokenInKeychain(_ tokenDict:NSDictionary) {
  }
  
  func makeSignUpRequest(_ userName:String, userEmail:String, userPassword:String) {
    // 1. Create HTTP request and set request header
//    let httpRequest = httpHelper.buildRequest("signup", method: "POST",
//                                              authType: HTTPRequestAuthType.httpBasicAuth)
    
    // 2. Password is encrypted with the API key
//    let encrypted_password = AESCrypt.encrypt(userPassword, password: HTTPHelper.API_AUTH_PASSWORD)
    
    // 3. Send the request Body
//    httpRequest.httpBody = "{\"full_name\":\"\(userName)\",\"email\":\"\(userEmail)\",\"password\":\"\(String(describing: encrypted_password))\"}".data(using: String.Encoding.utf8)
    
    // 4. Send the request
//    httpHelper.sendRequest(httpRequest as URLRequest, completion: {(data:Data!, error:NSError!) in
//        if error != nil {
//            let errorMessage = self.httpHelper.getErrorMessage(error)
//            self.displayAlertMessage("Error", alertDescription: errorMessage as String)
//
//            return
//        }
    
        self.displaSigninView()
        self.displayAlertMessage("Success", alertDescription: "Account has been created")
//    })
  }
  
  func makeSignInRequest(_ userEmail:String, userPassword:String) {   
  }
}
