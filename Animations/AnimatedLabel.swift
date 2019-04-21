//
//  AnimatedLabel.swift
//  Animations
//
//  Created by Terranz on 21/4/19.
//  Copyright © 2019 Terra Dev. All rights reserved.
//

import UIKit

class AnimatedLabel: UILabel {
    
    private let isInt: Bool
    
    private let startValue: Double
    private let endValue: Double
    
    private let startValueString: String
    private let endValueString: String
    
    private let animationDuration: Double
    private let animationStartTime = Date()
    
    private var displayLink: CADisplayLink?
    
    // Initialiser for Integers
    init(startValue: Double, endValue: Double, animationDuration: Double) {
        
        self.isInt = true
        
        self.startValue = startValue
        self.endValue = endValue
        self.animationDuration = animationDuration
        
        self.startValueString = ""
        self.endValueString = ""
        
        super.init(frame: .zero)
        
        commonInit()
    }
    
    // Initialiser for Strings
    init(startValue: String, endValue: String, animationDuration: Double) {
        
        self.isInt = false
        
        self.startValueString = startValue
        self.endValueString = endValue
        
        self.startValue = 0
        self.endValue = 0
        
        self.animationDuration = animationDuration
        super.init(frame: .zero)
        
        commonInit()
    }
    
    private func commonInit() {
        text = "\(startValue)"
        textAlignment = .center
        numberOfLines = 0
        font = UIFont.systemFont(ofSize: 20, weight: .heavy)
    
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.masksToBounds = true
    
        beginCounting()
    }
    
    private func beginCounting() {
        resetCounter()
        
        let link = CADisplayLink(target: self, selector: #selector(handleUpdate))
        
        // register the display link to the run loop
        link.add(to: .main, forMode: .default)
        
        displayLink = link
        
    }
    
    private func resetCounter() {
        displayLink?.invalidate()
    }
    
    // this gets called every loop in the internal time interval
    @objc private func handleUpdate() {
        
        let now = Date()
        
        // time since animation started
        let elapsedTime = now.timeIntervalSince(animationStartTime)
        
        if elapsedTime > animationDuration {
            
            if self.isInt {
                text = "\(Int(endValue))"
            } else {
                text = endValueString
            }
            
        } else {
            let percentage = elapsedTime / animationDuration
            
            if self.isInt {
                let countingText = startValue + ( percentage * (endValue - startValue) )
                text = "\(Int(countingText))"
            } else {
                let textDifference: Double = Double(endValueString.count - startValueString.count)
                let stringIndex = Int(percentage * textDifference)
                let textString = endValueString.prefix(stringIndex)
                text = String(textString)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
