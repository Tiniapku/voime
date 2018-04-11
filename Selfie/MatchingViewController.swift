//
//  MatchingViewController.swift
//  Selfie
//
//  Created by Tianyi Liu on 4/10/18.
//  Copyright © 2018 subhb.org. All rights reserved.
//

import UIKit
import AVFoundation
//TODO get a name list
class MatchingViewController: UIViewController {

    var Player = AVAudioPlayer()
    var playState = 1
    var userCount:Int = 4
    var likeState = [Int](repeating:0, count:4)
    var matchState = [Int]()
    var names = ["Vincent, 25",
        "Dylan, 22",
        "Andrew, 26",
        "Eric, 29",
        "Michael, 28",
        "Sean, 27"
        ]
    var alreadySeen = [Int]()
    var audioIndex = Int(arc4random_uniform(4) + 1)
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var profile_pic: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var profile_name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<userCount {
            matchState.append(Int(arc4random_uniform(2)))
        }
        print (matchState)
        alreadySeen = []
        playNext()
        
    }

    @IBAction func modalStopPlay(_ sender: Any) {
        Player.pause()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pause(_ sender: Any) {
        if playState == 1 {
        Player.pause()
        playButton.setImage(UIImage(named:"play"), for: .normal)
            playState = 0
        }
        else {
            Player.play()
            playState = 1
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
    }
    func getAudiosDirectory() -> URL {
        //        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return URL(string: "file:///Users/tianyi/Documents/18Winter/SI660/voime/starter/Selfie/audios/")!
    }
    
    func getProfileDirectory() -> String {
        return "file:///Users/tianyi/Documents/18Winter/SI660/voime/starter/profile_pics"
    }
    
    func getAudioName(num: Int) -> String {
        let curAudioName = "voice" + String(num) + ".mp3"
        return curAudioName
    }
    
    func getCoverImage(num:Int) -> String{
        let curImgName = String(num) + "_blurred"
        return curImgName
        
    }
    @IBAction func like(_ sender: Any) {
        //TODO: create a like_grey image
        print (matchState)
        if (matchState[audioIndex - 1] == 1) || (audioIndex == 4) {
        // matched, unveil the image
        let unveilImage = UIImage(named: String(audioIndex))
        profile_pic.image = unveilImage
        }
    }
    
    func playNext() {
        
        playState = 1
        
        while alreadySeen.contains(audioIndex)
         {
        audioIndex = Int(arc4random_uniform(UInt32(userCount)) + 1)
        }
        let coverImageName = getCoverImage(num: audioIndex)
        let coverImage: UIImage = UIImage(named: coverImageName)!
        profile_name.text = names[audioIndex - 1]
        profile_pic.image = coverImage
        
        var audioName = getAudioName(num: audioIndex)
        var audioPath = getAudiosDirectory().appendingPathComponent(audioName)
        do {
            try Player = AVAudioPlayer(contentsOf: audioPath)
//            Player.delegate = self
            Player.play()
            print (audioIndex)
            alreadySeen.append(audioIndex)
            print (alreadySeen)
            if alreadySeen.count == userCount {
                alreadySeen = []
//                let alert = UIAlertController(title: "Want more?", message: "Currently these are all our recommendations, you might want to change the filter to see more", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
            }
        }
        catch {
            print ("No such a file")
        }
    }
    
    @IBAction func playNextButton(_ sender: Any) {
        playNext()
    }
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        if flag {
//            self.playNext()
//        } else {
//            print ("failed")
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
