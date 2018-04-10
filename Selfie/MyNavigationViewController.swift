//
//  MyNavigationViewController.swift
//  Selfie
//
//  Created by Tianyi Liu on 4/9/18.
//  Copyright © 2018 subhb.org. All rights reserved.
//

import UIKit

class MyNavigationViewController: UITabBarController {
    let button = UIButton.init(type: .custom)
    
    
    override func viewDidLoad() {
        selectedIndex = 1
        super.viewDidLoad()
        button.setTitle("V", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.yellow, for: .highlighted)
        button.frame = CGRect(x:100, y:0, width:44, height:44)
        button.backgroundColor = UIColorFromRGB(rgbValue: 0xE59695, alpha: 1)
        
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColorFromRGB(rgbValue: 0xff5552, alpha: 0.8).cgColor
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        
        
        // Do any additional setup after loading the view.
    }
    
    func UIColorFromRGB(rgbValue: UInt, alpha: Float) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 74, width:64, height:64)
        button.layer.cornerRadius = 32
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
