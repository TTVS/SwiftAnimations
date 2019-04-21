//
//  CircleLoaderVC.swift
//  Animations
//
//  Created by Terranz on 20/4/19.
//  Copyright © 2019 Terra Dev. All rights reserved.
//

import UIKit

class CircleLoaderVC: UIViewController {
    
    private var urlSession: URLSession?
    
    deinit {
        print("Retreiving memory for CircleLoaderVC")
    }
    
    private var shapeLayer: CAShapeLayer?
    private var pulsatingLayer: CAShapeLayer?
    
    private let percentageLabel: UILabel = {
        let l = UILabel()
        l.text = "Start"
        l.font = UIFont.boldSystemFont(ofSize: 32)
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    private let urlString = "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObservers()
        title = "Circle Loader"
        view.backgroundColor = .backgroundColor
        setupCircleLayers()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        setupPercentageLabel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        endUrlSession()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .NSExtensionHostWillEnterForeground, object: nil)
    }
    
    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer?.add(animation, forKey: "pulsatingAnimation")
    }
    
    private func setupCircleLayers() {
        // create pulsating layer
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: .pulsatingFillColor)
        guard let pulsatingLayer = pulsatingLayer else { return }
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        // create background for loading layer
        let trackLayer = createCircleShapeLayer(strokeColor: .trackStrokeColor, fillColor: .backgroundColor)
        view.layer.addSublayer(trackLayer)
        
        // create loading layer
        shapeLayer = createCircleShapeLayer(strokeColor: .outlineStrokeColor, fillColor: .clear)
        guard let shapeLayer = shapeLayer else { return }
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
    }
    
    private func setupPercentageLabel() {
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    @discardableResult private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.position = view.center
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.lineCap = .round
        return shapeLayer
    }
    
    @objc private func handleTap() {
        beginDownloadingFile()
//        animateCircle()
    }
    
    // fake the animation of the loading circle
    private func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer?.add(basicAnimation, forKey: "fakeAnimation")
    }
}


extension CircleLoaderVC: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finish downloading file")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)

        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer?.strokeEnd = percentage
        }
    }
    
    private func beginDownloadingFile() {
        print("Attempting to download file")

        // reset loading stroke
        shapeLayer?.strokeEnd = 0
        self.percentageLabel.text = "0%"
        
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        guard let url = URL(string: self.urlString) else { return }
        guard let urlSession = urlSession else { return }
        urlSession.downloadTask(with: url).resume()
    }
    
    private func endUrlSession() {
        guard let urlSession = urlSession else { return }
        urlSession.invalidateAndCancel()
    }
}
