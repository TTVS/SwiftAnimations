//
//  PanAnimateVC.swift
//  Animations
//
//  Created by Terranz on 19/4/19.
//  Copyright © 2019 Terra Dev. All rights reserved.
//

import UIKit

class PanAnimateVC: UIViewController {
    
    deinit {
        print("Retreiving memory for PanAnimateVC")
    }
    
    let iconsContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        
        // configuration options
        let iconHeight: CGFloat = 38
        let padding: CGFloat = 6
        
        let images = [UIImage(named: "happy"),UIImage(named: "scared"),UIImage(named: "cry"),UIImage(named: "surprised"),UIImage(named: "angry"),UIImage(named: "nerd"),UIImage(named: "sleeping"),UIImage(named: "angel")]
        
        let arrangedSubviews = images.map({ (image) -> UIView in
            let iv = UIImageView(image: image)
            iv.isUserInteractionEnabled = true
            iv.layer.cornerRadius = iconHeight / 2
            return iv
        })
        
        
        // container view
        let height = iconHeight + 2 * padding
        let numberOfIcons = CGFloat(arrangedSubviews.count)
        let width = numberOfIcons * iconHeight + (numberOfIcons + 1) * padding
        
        v.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        v.layer.cornerRadius = v.frame.height / 2
        
        // shadow
        v.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        v.layer.shadowRadius = 8
        v.layer.shadowOpacity = 0.5
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        
        // stack view
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        v.addSubview(stackView)
        stackView.frame = v.frame
        
        return v
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pan and Animate"
        
        setupViewLayout()
        setupLongPressGesture()
    }
    
    
    // MARK: - Helpers
    
    private func setupViewLayout() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        let instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.text = "Long press anywhere on the screen"
        instructions.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        view.addSubview(instructions)
        
        NSLayoutConstraint.activate([
            instructions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            instructions.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            ])
    }
    
    private func setupLongPressGesture() {
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    @objc private func handleLongPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            
            // animate container view upwards
            handleGestureBegan(gesture: gesture)
            
        } else if gesture.state == .ended {
            
            // clean up the animation
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                // animate all the imageviews back to original
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                // animate container view back down
                self.iconsContainerView.transform = self.iconsContainerView.transform.translatedBy(x: 0, y: 50)
                self.iconsContainerView.alpha = 0
                
            }, completion: { (_) in
                self.iconsContainerView.removeFromSuperview()
            })
            
        } else if gesture.state == .changed {
            handleGestureChanged(gesture: gesture)
        }
    }
    
    private func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        view.addSubview(iconsContainerView)
        
        let pressedLocation = gesture.location(in: self.view)
        let centeredX = ( view.frame.width - iconsContainerView.frame.width ) / 2
        let transformYLocation = pressedLocation.y - iconsContainerView.frame.height
        
        
        // beginning of animation
        iconsContainerView.alpha = 0
        self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        // final position transformation of container view
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.iconsContainerView.alpha = 1
            self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: transformYLocation)
        })
    }
    
    private func handleGestureChanged(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: self.iconsContainerView)
        
        // allow for panning on whole screen y axis
        let fixedYLocation = CGPoint(x: pressedLocation.x, y: self.iconsContainerView.frame.height / 2)
        
        let hitTestView = iconsContainerView.hitTest(fixedYLocation, with: nil)
        
        if hitTestView is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                // animate all the imageviews back to original
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                // animate the current imageview up
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
            })
        }
        
    }
}

