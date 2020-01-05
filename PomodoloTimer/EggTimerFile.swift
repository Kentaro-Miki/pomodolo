//
//  EggTimerFile.swift
//  TestTimer
//
//  Created by 三木健太郎 on 2019/12/19.
//  Copyright © 2019 三木健太郎. All rights reserved.
//

import Foundation

protocol EggTimerProtocol {
    func timerRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval)
    func timerHasFinished(_ timer: EggTimer)
}

class EggTimer {
    
    var timer: Timer? = nil
    var startTime: Date?
    var duration: TimeInterval = 1500
    var elapsedTime: TimeInterval = 0
    var isStoped: Bool {
        //なぜこの式でreturnしているのかがわからない
        return timer == nil && elapsedTime == 0
    }
    var isPaused: Bool {
        //なぜこの式でreturnしているのかがわからない
        return timer == nil && elapsedTime > 0
    }
    var delegate: EggTimerProtocol?
    
    //タイマーアクションの意味がわからない
    @objc dynamic func timerAction() {
        
        guard let startTime = startTime else {
            return
        }
        
        elapsedTime = -startTime.timeIntervalSinceNow
        
        let secondsRemaining = (duration - elapsedTime).rounded()
        
        if secondsRemaining <= 0 {
            resetTimer()
            //これ2つ何？
            delegate?.timerHasFinished(self)
        } else {
            delegate?.timerRemainingOnTimer(self, timeRemaining: secondsRemaining)
        }
    }
    
    func startTimer() {
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        timerAction()
    }
    
    //startTimeの再設定
    func resumeTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        timerAction()
    }
    
    func stopTimer() {
        
        timer?.invalidate()
        timer = nil
        
        timerAction()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        duration = 1500
        elapsedTime = 0
        
        timerAction()
    }
    
}



