//
//  ChainAnimateVC.swift
//  Animations
//
//  Created by Terranz on 20/4/19.
//  Copyright © 2019 Terra Dev. All rights reserved.
//

import UIKit

class ChainAnimateVC: UIViewController {
    
    deinit {
        print("Retreiving memory for ChainAnimateVC")
    }
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Welcome To Company XYZ"
        l.font = UIFont(name: "Futura", size: 34)
        l.numberOfLines = 0
        return l
    }()
    
    private let bodyLabel: UILabel = {
        let l = UILabel()
        l.text = "Hello there! Thanks so much for downloading our brand new app and giving us a try. Make sure to leave us a good review in the AppStore."
        l.font = UIFont(name: "Futura", size: 18)
        l.numberOfLines = 0
        return l
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = . vertical
        sv.spacing = 20
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chain Animate"
        view.backgroundColor = .white
        
        addStackView()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations)))
    }
    
    private func addStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            ])
    }
    
    @objc private func handleTapAnimations() {
        animateLabelWithDelay(delay: 0, label: self.titleLabel)
        animateLabelWithDelay(delay: 0.5, label: self.bodyLabel)
    }
    
    private func animateLabelWithDelay(delay: TimeInterval, label: UILabel) {
        UIView.animate(withDuration: 0.5, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            label.transform = CGAffineTransform(translationX: -30, y: 0)
            
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                label.alpha = 0
                label.transform = self.titleLabel.transform.translatedBy(x: 0, y: -200)
                
            })
        }
    }
}
