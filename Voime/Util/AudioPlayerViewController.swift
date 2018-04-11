//
//  AudioPlayerViewController.swift
//  Selfie
//
//  Created by Tianyi Liu on 4/6/18.
//  Copyright © 2018 subhb.org. All rights reserved.
//

import UIKit

class AudioPlayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func recordAudio(_ sender: Any) {
        print("start record...")
        timeCounter.text = "00:" + String(count)
        timeCounter.textColor = UIColor.black
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update_time), userInfo: nil, repeats: true)
        
        
    }
    var count = 10
    func update_time() {
        if (count > 0) {
            count -= 1
            timeCounter.text = "00:0" + String(count)
        }
    }
    
    @IBOutlet weak var timeCounter: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
