//
//  CounterVC.swift
//  Animations
//
//  Created by Terranz on 20/4/19.
//  Copyright © 2019 Terra Dev. All rights reserved.
//

import UIKit

class CounterVC: UIViewController {
    
    deinit {
        print("Retreiving memory for CounterVC")
    }
    
    private var numberStartValue: Double = 0
    private let numberEndValue: Double = 1200
    
    private var textStartValue = ""
    private let textEndValue = "Some quite long text that is weird like really weird but still its ok you know"
    
    private let maximumAnimationDuration: Double = 1.5
    private let animationStartTime = Date()
    
    private let countingLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return l
    }()
    
    private let textLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return l
    }()
    
    private var displayLink: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Text Animation"
        
        setupView()
        setupLayout()
        
        // use CADisplayLink to animate text
        startDisplayLink()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDisplayLink()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopDisplayLink()
    }
    
    private func stopDisplayLink() {
        displayLink?.invalidate()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        
        let stackView = UIStackView(arrangedSubviews: [
            countingLabel,
            textLabel
            ])
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.frame = view.frame   
    }
    
    private func startDisplayLink() {
        stopDisplayLink()
        
        let link = CADisplayLink(target: self, selector: #selector(handleUpdate))
        
        // register the display link to the run loop
        link.add(to: .main, forMode: .default)
        
        displayLink = link
        
    }
    
    // this gets called every loop in the internal time interval
    @objc private func handleUpdate() {
        
        let now = Date()
        
        // time since animation started
        let elapsedTime = now.timeIntervalSince(animationStartTime)
        
        if elapsedTime > maximumAnimationDuration {
            
            // for integer counter
            self.countingLabel.text = "\(Int(numberEndValue))"
            
            // for string storytelling
            self.textLabel.text = textEndValue
            
        } else {
            let percentage = elapsedTime / maximumAnimationDuration
            
            
            // for integer counter
            let countingText = numberStartValue + ( percentage * (numberEndValue - numberStartValue) )
            self.countingLabel.text = "\(Int(countingText))"
            
            
            // for string storytelling
            let textDifference: Double = Double(textEndValue.count - textStartValue.count)
            let stringIndex = Int(percentage * textDifference)
            let stringText = textEndValue.prefix(stringIndex)
            self.textLabel.text = String(stringText)
            
        }
    }
}
