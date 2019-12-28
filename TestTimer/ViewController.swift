//
//  ViewController.swift
//  TestTimer
//
//  Created by 三木健太郎 on 2019/12/17.
//  Copyright © 2019 三木健太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var eggTimer = EggTimer()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var startButton: UIButton!
   
    override func viewDidLoad() {
      super.viewDidLoad()
       // Do any additional setup after loading the view.
      self.startButton.layer.borderColor = UIColor.white.cgColor
        self.startButton.layer.borderWidth = 1
      self.stopButton.layer.borderColor = UIColor.white.cgColor
        self.stopButton.layer.borderWidth = 1
      self.resetButton.layer.borderColor = UIColor.white.cgColor
        self.resetButton.layer.borderWidth = 1
      self.restartButton.layer.borderColor = UIColor.white.cgColor
       self.restartButton.layer.borderWidth = 1
        eggTimer.delegate = self
      updateDisplay(for: 1500)
        startButton.alpha = 1.0
        stopButton.alpha = 0
        resetButton.alpha = 0
        restartButton.alpha = 0
    }

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func startTimer(_ sender: Any) {
//        if eggTimer.isPaused {
//            //スタートしてから、途中で止まっている状態
////                   eggTimer.resumeTimer()
//            stopButton.alpha = 1.0
//            startButton.alpha = 0
//        } else
        if eggTimer.isPaused == false {
            //スタート前の状態
                   eggTimer.duration = 1500
                   eggTimer.startTimer()
               }
        startButton.alpha = 0
        stopButton.alpha = 1.0
        resetButton.alpha = 0
    }
    
    @IBAction func stopTimer(_ sender: Any) {
    eggTimer.stopTimer()
        stopButton.alpha = 0
        restartButton.alpha = 1.0
        resetButton.alpha = 1.0
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        eggTimer.resetTimer()
        updateDisplay(for: 5)
        resetButton.alpha = 0
        startButton.alpha = 1.0
        restartButton.alpha = 0
    }
    
    @IBAction func restartButton(_ sender: Any) {
        eggTimer.resumeTimer()
        stopButton.alpha = 1.0
        restartButton.alpha = 0
        resetButton.alpha = 0
    }
    

    func configureButtonAnswers() {
        let enableStart: Bool
        let enableStop: Bool
        let enableReset: Bool
        
        if eggTimer.isStoped {
            enableStart = false
            enableStop = false
            enableReset = true
        } else if eggTimer.isPaused {
            enableStart = true
            enableStop = false
            enableReset = true
        } else {
            enableStart = false
            enableStop = true
            enableReset = false
        }
        
        startButton.isEnabled = enableStart
        stopButton.isEnabled = enableStop
        resetButton.isEnabled = enableReset
        
    }
    
}

extension ViewController: EggTimerProtocol {
    func timerRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval) {
        updateDisplay(for: timeRemaining)
    }
    
    func timerHasFinished(_ timer: EggTimer) {
        updateDisplay(for: 0)
    }
}

extension ViewController {
    
    func updateDisplay(for timeRemaining: TimeInterval) {
        textField.text = textToDisplay(for: timeRemaining)
        //卵の画像は今回入れない
    }
    
    func textToDisplay(for timeRemaining: TimeInterval) -> String {
        if timeRemaining == 0 {
            self.performSegue(withIdentifier: "moveSegue", sender: nil)
        }
        
        let minutesRemaining = floor(timeRemaining / 60)
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        
        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
        
        return timeRemainingDisplay
    }
}

//extension CALayer {
//    func setBorderUIColor(_ color: UIColor) {
//        self.borderColor = color.cgColor
//    }
//}
















