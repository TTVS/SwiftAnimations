//
//  StatsStackView.swift
//  Animations
//
//  Created by Terranz on 21/4/19.
//  Copyright © 2019 Terra Dev. All rights reserved.
//

import UIKit

class StatsStackView: UIStackView {
    
    private let countingLabel1 = AnimatedLabel(startValue: 1, endValue: 10, animationDuration: 5)
    private let countingLabel2 = AnimatedLabel(startValue: 100, endValue: 10000, animationDuration: 10)
    private let countingLabel3 = AnimatedLabel(startValue: 1, endValue: 1000, animationDuration: 4)
    
    private let textLabel = AnimatedLabel(startValue: "", endValue: "Some quite long text that is weird like really weird but still its ok you know", animationDuration: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        self.addArrangedSubview(countingLabel1)
        self.addArrangedSubview(countingLabel2)
        self.addArrangedSubview(countingLabel3)
        self.addArrangedSubview(textLabel)
        
        self.distribution = .fillEqually
        self.axis = .vertical
        self.spacing = 32
        self.layoutMargins = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
