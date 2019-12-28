//
//  RestViewController.swift
//  TestTimer
//
//  Created by 三木健太郎 on 2019/12/20.
//  Copyright © 2019 三木健太郎. All rights reserved.
//

import UIKit

class RestViewController: UIViewController {

    var restEggTimer = RestEggTimer()
    
//    let controller = self.presentingViewController as? ViewController
//    var restTimeField = String(updateRestDisplay(for: 5))

    override func viewDidLoad() {
        super.viewDidLoad()
        restEggTimer.restDelegate = self
        updateRestDisplay(for: 300)
        self.restStartButton.layer.borderColor = UIColor.white.cgColor
        self.restStartButton.layer.borderWidth = 1
        self.restStopButton.layer.borderColor = UIColor.white.cgColor
        self.restStopButton.layer.borderWidth = 1
        self.restResetButton.layer.borderColor = UIColor.white.cgColor
        self.restResetButton.layer.borderWidth = 1
        self.restRestartButton.layer.borderColor = UIColor.white.cgColor
        self.restRestartButton.layer.borderWidth = 1
        // Do any additional setup after loading the view.
        restStartButton.alpha = 1.0
        restStopButton.alpha = 0
        restResetButton.alpha = 0
        restRestartButton.alpha = 0
    }
    
    @IBOutlet weak var restTimeField: UITextField!
    @IBOutlet weak var restStartButton: UIButton!
    @IBOutlet weak var restStopButton: UIButton!
    @IBOutlet weak var restResetButton: UIButton!
    @IBOutlet weak var restRestartButton: UIButton!
    @IBOutlet weak var restFinished: UIButton!
    
    @IBAction func startRest(_ sender: Any) {
      if restEggTimer.restIsPaused == false
        {
       //スタート前の状態
               restEggTimer.restDuration = 300
               restEggTimer.restStartTimer()
        }
        restStartButton.alpha = 0
        restStopButton.alpha = 1.0
        restResetButton.alpha = 0
        }
    
    
    @IBAction func StopRest(_ sender: Any) {
        restEggTimer.restStopTimer()
        restStopButton.alpha = 0
        restRestartButton.alpha = 1.0
        restResetButton.alpha = 1.0
    }
    @IBAction func resetRest(_ sender: Any) {
        restEggTimer.restResetTimer()
        updateRestDisplay(for: 300)
        restResetButton.alpha = 0
        restStartButton.alpha = 1.0
        restRestartButton.alpha = 0
    }
    @IBAction func restartRest(_ sender: Any) {
        restEggTimer.restResumeTimer()
        restStopButton.alpha = 1.0
        restRestartButton.alpha = 0
        restResetButton.alpha = 0
    }
    
    @IBAction func finishRest(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
//        updateDisplay(for: 5)
        restStartButton.alpha = 1.0
        restStopButton.alpha = 0
        restRestartButton.alpha = 0
        restResetButton.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let controller = self.presentingViewController as? ViewController {
            controller.startButton.alpha = 1.0
            controller.stopButton.alpha = 0
            controller.resetButton.alpha = 0
            controller.restartButton.alpha = 0
            controller.updateDisplay(for: 5)
        }
    }
    

    func restConfigureButtonAnswers() {
        let restEnableStart: Bool
        let restEnableStop: Bool
        let restEnableReset: Bool
        
        if restEggTimer.restIsStoped {
            restEnableStart = true
            restEnableStop = false
            restEnableReset = false
        } else if restEggTimer.restIsPaused {
            restEnableStart = true
            restEnableStop = false
            restEnableReset = true
        } else {
            restEnableStart = false
            restEnableStop = true
            restEnableReset = false
        }
        
        restStartButton.isEnabled = restEnableStart
        restStopButton.isEnabled = restEnableStop
        restResetButton.isEnabled = restEnableReset
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension RestViewController: restEggTimerProtocol {
    func restTimerRemainingOnTimer(_ restTimer: RestEggTimer, restTimeRemaining: TimeInterval) {
        updateRestDisplay(for: restTimeRemaining)
    }
    
    func restTimerHasFinished(_ restTimer: RestEggTimer) {
        updateRestDisplay(for: 0)
    }
}

extension RestViewController {

    func updateRestDisplay(for restTimeRemaining: TimeInterval) {
    restTimeField.text = textToRestDisplay(for: restTimeRemaining)
    //卵の画像は今回入れない
}
    
    //画面遷移
    func textToRestDisplay(for restTimeRemaining: TimeInterval) -> String {
        if restTimeRemaining == 0, let controller = self.presentingViewController as? ViewController {
//            controller.startButton.alpha = 1.0
//            controller.stopButton.alpha = 1.0
//            controller.resetButton.alpha = 1.0
            controller.startButton.alpha = 1.0
            controller.stopButton.alpha = 0
            controller.resetButton.alpha = 0
            controller.restartButton.alpha = 0
            controller.updateDisplay(for: 300)
            self.dismiss(animated: true, completion: nil)
        }
        
        let restMinutesRemaining = floor(restTimeRemaining / 60)
        let restSecondsRemaining = restTimeRemaining - (restMinutesRemaining * 60)
        
        let restSecondsDisplay = String(format: "%02d", Int(restSecondsRemaining))
        let restTimeRemainingDisplay = "\(Int(restMinutesRemaining)):\(restSecondsDisplay)"
        
        return restTimeRemainingDisplay
    }
    

}
//, restFinished.isEnabled == true
