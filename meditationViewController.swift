//
//  meditationViewController.swift
//  Touchstone Final
//
//  Created by Anila Elisabetta Hoxha on 12/7/18.
//  Copyright © 2018 Anila Elisabetta Hoxha. All rights reserved.
//

import UIKit

class meditationViewController: UIViewController {
    
    
    
    enum IntervalType {
        case Pomodoro
        case RestBreak
    }
    let intervals: [IntervalType] = [.Pomodoro,
                                     .RestBreak,
                                     .Pomodoro,
                                     .RestBreak,
                                     .Pomodoro,
                                     .RestBreak,
                                     .Pomodoro]
    var currentInterval = 0
    
    
    let pomodoroIntervalTime = 5 //
    let restBreakIntervalTime = 5 //
    var timeRemaining = 0
    
    
    var myTimer = Timer()
    
    
    @IBAction func onCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    
    
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetToBeginning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func resetToBeginning() {
        currentInterval = 0
        
        intervalLabel.text = "Ready to meditate?"
        startPauseButton.setTitle("Start", for: .normal)
        resetButton.isEnabled = false
        timeRemaining = pomodoroIntervalTime
        updateDisplay()
    }
    
    @IBAction func startPauseButtonPressed(_ sender: UIButton) {
        if myTimer.isValid {
            startPauseButton.setTitle("Resume", for: .normal)
            resetButton.isEnabled = true
            pauseTimer()
        } else {
            
            startPauseButton.setTitle("Pause", for: .normal)
            resetButton.isEnabled = false
            if currentInterval == 0 && timeRemaining == pomodoroIntervalTime {
                
                startNextInterval()
            } else {
                
                startTimer()
            }
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        if myTimer.isValid {
            
            myTimer.invalidate()
        }
        resetToBeginning()
    }
    
    func startNextInterval() {
        if currentInterval < intervals.count {
            
            
            if intervals[currentInterval] == .Pomodoro {
                // Pomodoro interval
                timeRemaining = pomodoroIntervalTime
                intervalLabel.text = "Breathe In"
                let tomatoes = (currentInterval + 2) / 2
                print("\(tomatoes) tomatoes")
                
            } else {
                // Rest break interval
                timeRemaining = restBreakIntervalTime
                intervalLabel.text = "Breathe Out"
            }
            updateDisplay()
            startTimer()
            currentInterval += 1
        } else {
            
            resetToBeginning()
        }
    }
    
    func updateDisplay() {
        let (minutes, seconds) = minutesAndSeconds(from: timeRemaining)
        minutesLabel.text = formatMinuteOrSecond(minutes)
        secondsLabel.text = formatMinuteOrSecond(seconds)
    }
    
    
    func startTimer() {
        myTimer = Timer.scheduledTimer(timeInterval: 1,
                                       target: self,
                                       selector: #selector(timerTick),
                                       userInfo: nil,
                                       repeats: true)
    }
    
    @objc func timerTick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            print("time: \(timeRemaining)")
            updateDisplay()
        } else {
            myTimer.invalidate()
            startNextInterval()
        }
    }
    
    func pauseTimer() {
        myTimer.invalidate()
        intervalLabel.text = "Paused."
    }
    
    
    
    func minutesAndSeconds(from seconds: Int) -> (Int, Int) {
        return (seconds / 60, seconds % 60)
    }
    
    
    func formatMinuteOrSecond(_ number: Int) -> String {
        return String(format: "%02d", number)
    }
    
}


