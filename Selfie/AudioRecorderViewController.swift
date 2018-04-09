//
//  AudioRecorderViewController.swift
//  Selfie
//
//  Created by Tianyi Liu on 4/9/18.
//  Copyright © 2018 subhb.org. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 9.0, *)
@available(iOS 9.0, *)
class AudioRecorderViewController: UIViewController, AVAudioRecorderDelegate {
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var count = 10
    var countdown : Timer? = nil {
        willSet {
            countdown?.invalidate()
        }
    }
    @IBOutlet weak var RecordReminder: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print ("I'm here to record")
                        self.loadRecordingUI()
                    } else {
                        print ("Failed to record")
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRecordingUI() {
        recordButton = UIButton(frame: CGRect(x: 84, y: 64, width: 160, height: 160))
        RecordReminder.text = "Record an audio to start Voime"
//        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
        recordButton.setImage( #imageLiteral(resourceName: "voice"), for: .normal)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        view.addSubview(recordButton)
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        var countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update_time), userInfo: nil, repeats: true)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    func update_time() {
        if (count > 0) {
            count -= 1
            RecordReminder.text = "00:0" + String(count)
        }
        else if (count == 0){
            
            finishRecording(success: true)
//            RecordReminder.text = "Tap to Re-record"
//        continueButton.setTitleColor(UIColor.black, for: .normal)
            
        }
    }
    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return URL(string: "file:///Users/tianyi/Documents/18Winter/SI660/voime/starter/Selfie/audios")!
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            RecordReminder.text = "Successful!! Tap to Re-record"
            continueButton.setTitleColor(UIColor.black, for: .normal)
            countdown?.invalidate()
            countdown = nil
            count = -1
        } else {
            RecordReminder.text = "Record an audio to start Voime"
            // recording failed :(
        }
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
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
