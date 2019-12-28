//
//  RestEggTimerFile.swift
//  TestTimer
//
//  Created by 三木健太郎 on 2019/12/20.
//  Copyright © 2019 三木健太郎. All rights reserved.
//

import Foundation

protocol restEggTimerProtocol {
    func restTimerRemainingOnTimer(_ restTimer: RestEggTimer, restTimeRemaining: TimeInterval)
    func restTimerHasFinished(_ restTimer: RestEggTimer)
}

class RestEggTimer {
    var restTimer: Timer? = nil
    var restStartTime: Date?
    var restDuration: TimeInterval = 360
    var restElapsedTime: TimeInterval = 0
    var restIsStoped: Bool {
        //なぜこの式でreturnしているのかがわからない
        return restTimer == nil && restElapsedTime == 0
    }
    var restIsPaused: Bool {
        //なぜこの式でreturnしているのかがわからない
        return restTimer == nil && restElapsedTime > 0
    }
    var restDelegate: restEggTimerProtocol?
    
    //タイマーアクションの意味がわからない
    @objc dynamic func restTimerAction() {
        
        guard let restStartTime = restStartTime else {
            return
        }
        
        restElapsedTime = -restStartTime.timeIntervalSinceNow
        
        let restSecondsRemaining = (restDuration - restElapsedTime).rounded()
        
        if restSecondsRemaining <= 0 {
            restResetTimer()
            //これ2つ何？
            restDelegate?.restTimerHasFinished(self)
        } else {
            restDelegate?.restTimerRemainingOnTimer(self, restTimeRemaining: restSecondsRemaining)
        }
    }
    
    func restStartTimer() {
        restStartTime = Date()
        restElapsedTime = 0
        
        restTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(restTimerAction), userInfo: nil, repeats: true)
        
        restTimerAction()
    }
    
    //startTimeの再設定
    func restResumeTimer() {
        restStartTime = Date(timeIntervalSinceNow: -restElapsedTime)
        
        restTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(restTimerAction), userInfo: nil, repeats: true)
        
        restTimerAction()
    }
    
    func restStopTimer() {
        
        restTimer?.invalidate()
        restTimer = nil
        
        restTimerAction()
    }
    
    func restResetTimer() {
        restTimer?.invalidate()
        restTimer = nil
        
        restStartTime = nil
        restDuration = 360
        restElapsedTime = 0
        
        restTimerAction()
    }
    
}



