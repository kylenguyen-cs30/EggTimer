//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//  Hoang Nguyen
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var timeRemaining = 60
    
    let eggTimers = ["Soft" : 300, "Medium": 420, "Hard": 720]
    
    var timer = Timer() // Program need a variable to stop timer at mid way.
    var totalTime = 0
    var secondPassed = 0
    var percentageProgress = 0
    var player:AVAudioPlayer!
    
    //progress bar
    @IBOutlet weak var progressBar: UIProgressView!
    
    //title label
    @IBOutlet weak var titleLabel: UILabel!
    //Harness selected button
    @IBAction func harnessSelection(_ sender: UIButton) {
        progressBar.progress = 0.0

        timer.invalidate() // stop the previous timer if the user change their mind at mid way.
        let hardness = sender.currentTitle!
        totalTime = eggTimers[hardness]!
        titleLabel.text = "Cooking \(sender.currentTitle!) your egg"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func reset(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        titleLabel.text = "How do you like your eggs?"
    }
    
    @objc func updateCounter()
    {
        if secondPassed < totalTime{
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
        }else {
            timer.invalidate()
            playAlarm()
            titleLabel.text = "DONE"
        }
    }
    
    //Alarm the user about the egg
    func playAlarm()
    {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
}
