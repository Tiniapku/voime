//
//  ProfileViewController.swift
//  Voime
//
//  Created by Tianyi Liu on 4/10/18.
//  Copyright © 2018 subhb.org. All rights reserved.
//

import UIKit
import AVFoundation
class ProfileViewController: UIViewController {
    var Player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlayEricIntro(_ sender: Any) {
        
        let audiourl = URL(string: "file:///Users/tianyi/Documents/18Winter/SI660/voime/starter/Voime/audios/voice4.mp3")
        do {
            try Player = AVAudioPlayer(contentsOf: audiourl!)
            
            Player.play()
        }
        catch {
            print ("No such a file")
        }
    }
    
    @IBAction func playMusic(_ sender: Any) {
        
        let audiourl = URL(string: "file:///Users/tianyi/Documents/18Winter/SI660/voime/starter/Voime/audios/song1.mp3")
        
        do {
            try Player = AVAudioPlayer(contentsOf: audiourl!)
            
            Player.play()
        }
        catch {
            print ("No such a file")
        }
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
