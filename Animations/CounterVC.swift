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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Text Animation"
        view.backgroundColor = .backgroundColor
        
        let stackView = StatsStackView()
        view.addSubview(stackView)
        stackView.frame = view.frame
    }
}
