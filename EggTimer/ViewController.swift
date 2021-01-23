//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // define timer time in dictionary
    // let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    // default timer seconds
    var secondsRemaining = 60
    var secondsTotal = 60
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timerProgress: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // Initiate
        timer.invalidate()
        timerProgress.progress = 1.0
        let hardness  = sender.currentTitle! //Soft, Medium, Hard
        titleLabel.text = hardness
        
        secondsRemaining = eggTimes[hardness]!
        secondsTotal = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            // count down and print
            print("\(secondsRemaining) seconds.")
            secondsRemaining -= 1
        
            // update progress bar
            let percentageProgress = Float(secondsRemaining) / Float(secondsTotal)
            timerProgress.progress = percentageProgress
            
        } else if secondsRemaining == 0 {
            // show Done
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "service-bell", withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

 
}
 
