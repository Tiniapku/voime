//
//  HTTPHelper.swift
//  Selfie
//
//  Created by Subhransu Behera on 18/11/14.
//  Copyright (c) 2014 subhb.org. All rights reserved.
//

import Foundation

enum HTTPRequestAuthType {
  case httpBasicAuth
  case httpTokenAuth
}

enum HTTPRequestContentType {
  case httpJsonContent
  case httpMultipartContent
}

struct HTTPHelper {
  static let API_AUTH_NAME = "tinia"
  static let API_AUTH_PASSWORD = "wdprrerprp2elsosrrphknldnsaiulpnsrolnhupadosowr2oopodwii2hhuiona"
  static let BASE_URL = "https://voime.herokuapp.com/api"
  
  func buildRequest(_ path: String!, method: String, authType: HTTPRequestAuthType,
    requestContentType: HTTPRequestContentType = HTTPRequestContentType.httpJsonContent, requestBoundary:String = "") -> NSMutableURLRequest {
      // 1. Create the request URL from path
    let requestURL = URL(string: "\(HTTPHelper.BASE_URL)/\(path)")
      var request = NSMutableURLRequest(url: requestURL!)
      
      // Set HTTP request method and Content-Type
      request.httpMethod = method
      
      // 2. Set the correct Content-Type for the HTTP Request. This will be multipart/form-data for photo upload request and application/json for other requests in this app
      switch requestContentType {
      case .httpJsonContent:
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      case .httpMultipartContent:
        let contentType = "multipart/form-data; boundary=\(requestBoundary)"
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
      }
      
      // 3. Set the correct Authorization header.
      switch authType {
      case .httpBasicAuth:
        // Set BASIC authentication header
        let basicAuthString = "\(HTTPHelper.API_AUTH_NAME):\(HTTPHelper.API_AUTH_PASSWORD)"
        let utf8str = (basicAuthString).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        let base64EncodedString = utf8str?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
        request.addValue("Basic \(base64EncodedString!)", forHTTPHeaderField: "Authorization")
      case .httpTokenAuth:
        // Retreieve Auth_Token from Keychain
        if let userToken = KeychainAccess.passwordForAccount("Auth_Token", service: "KeyChainService") as String? {
          // Set Authorization header
          request.addValue("Token token=\(userToken)", forHTTPHeaderField: "Authorization")
        }
      }
      
      return request
  }
  
  
  func sendRequest(_ request: URLRequest, completion:@escaping (Data?, NSError?) -> Void) -> () {
    // Create a NSURLSession task
    let session = URLSession.shared
    _ = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
      if error != nil {
        DispatchQueue.main.async(execute: { () -> Void in
            completion(data, error! as NSError)
        })
        
        return
      }
      
        DispatchQueue.main.async(execute: { () -> Void in
            if let httpResponse = response as? HTTPURLResponse {
          if httpResponse.statusCode == 200 {
            completion(data, nil)
                }
        }
      })
        } as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void as! (Data?, URLResponse?, Error?) -> Void
    
    // start the task
//    task.resume()
  }
  
  func uploadRequest(_ path: String, data: Data, title: String) -> NSMutableURLRequest {
    let boundary = "---------------------------14737809831466499882746641449"
    let request = buildRequest(path, method: "POST", authType: HTTPRequestAuthType.httpTokenAuth,
      requestContentType:HTTPRequestContentType.httpMultipartContent, requestBoundary:boundary) as NSMutableURLRequest
    
    let bodyParams : NSMutableData = NSMutableData()
    
    // build and format HTTP body with data
    // prepare for multipart form uplaod
    
    let boundaryString = "--\(boundary)\r\n"
    let boundaryData = boundaryString.data(using: String.Encoding.utf8) as Data!
    bodyParams.append(boundaryData!)
    
    // set the parameter name
    let imageMeteData = "Content-Disposition: attachment; name=\"image\"; filename=\"photo\"\r\n".data(using: String.Encoding.utf8, allowLossyConversion: false)
    bodyParams.append(imageMeteData!)
    
    // set the content type
    let fileContentType = "Content-Type: application/octet-stream\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: false)
    bodyParams.append(fileContentType!)
    
    // add the actual image data
    bodyParams.append(data)
    
    let imageDataEnding = "\r\n".data(using: String.Encoding.utf8, allowLossyConversion: false)
    bodyParams.append(imageDataEnding!)
    
    let boundaryString2 = "--\(boundary)\r\n"
    let boundaryData2 = boundaryString.data(using: String.Encoding.utf8) as Data!
    
    bodyParams.append(boundaryData2!)
    
    // pass the caption of the image
    let formData = "Content-Disposition: form-data; name=\"title\"\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: false)
    bodyParams.append(formData!)
    
    let formData2 = title.data(using: String.Encoding.utf8, allowLossyConversion: false)
    bodyParams.append(formData2!)
    
    let closingFormData = "\r\n".data(using: String.Encoding.utf8, allowLossyConversion: false)
    bodyParams.append(closingFormData!)
    
    let closingData = "--\(boundary)--\r\n"
    let boundaryDataEnd = closingData.data(using: String.Encoding.utf8) as Data!
    
    bodyParams.append(boundaryDataEnd!)
    
    request.httpBody = bodyParams as Data
    return request
  }
  
  func getErrorMessage(_ error: NSError) -> NSString {
    var errorMessage : NSString
    
    // return correct error message
    if error.domain == "HTTPHelperError" {
      let userInfo = error.userInfo as NSDictionary!
      errorMessage = userInfo?.value(forKey: "message") as! NSString
    } else {
      errorMessage = error.description as NSString
    }
    
    return errorMessage
  }
}
