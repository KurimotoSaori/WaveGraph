//
//  SampleViewController.swift
//  wave
//
//  Created by saori on 2019/01/28.
//  Copyright © 2019年 saori. All rights reserved.
//

import UIKit
import AVFoundation

class SampleViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet var label: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var playButton: UIButton!

    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var isRecording = false
    var isPlaying = false

    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.record, mode: .default, options: [])
        try! session.setActive(true)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        audioRecorder = try! AVAudioRecorder(url: getURL(), settings: settings)

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.audioRecorder.updateMeters()
            print("aaaaaaaa: \(self.audioRecorder.peakPower(forChannel: 0))")
        })
    }

    @IBAction func tappedButton(_ sender: Any) {
        if !isRecording {

            audioRecorder.delegate = self
            audioRecorder.record()

            isRecording = true

            label.text = "録音中"
            recordButton.setTitle("STOP", for: .normal)
            playButton.isEnabled = false
        }else{
            audioRecorder.stop()
            isRecording = false

            label.text = "待機中"
            recordButton.setTitle("RECORD", for: .normal)
            playButton.isEnabled = true
        }
    }

    func getURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let url = docsDirect.appendingPathComponent("recording.m4a")
        return url
    }
}
