//
//  Delay.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/7/5.
//

import Foundation

class Delay {
    
    private var seconds: Double
    var workItem: DispatchWorkItem?
    
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func performWork(_ work: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    func cancel() {
        workItem?.cancel()
    }
}
