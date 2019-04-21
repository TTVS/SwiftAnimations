//
//  RootCollectionVC.swift
//  Animations
//
//  Created by Terranz on 19/4/19.
//  Copyright © 2019 Terra Dev. All rights reserved.
//

import UIKit

class RootCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "Cell"
    private let textColors = [UIColor.cyan, .green, .blue, .purple]
    private let textLabels = ["Pan And Animate", "CADisplayLink", "Chain Animation", "CircleLoaderVC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Main Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.backgroundColor = .backgroundColor
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textLabels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            ])
        
        title.text = textLabels[indexPath.row]
        title.textColor = textColors[indexPath.row]
        cell.backgroundColor = .outlineStrokeColor
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            navigationController?.pushViewController(PanAnimateVC(), animated: true)
        } else if indexPath.row == 1 {
            navigationController?.pushViewController(CounterVC(), animated: true)
        } else if indexPath.row == 2 {
            navigationController?.pushViewController(ChainAnimateVC(), animated: true)
        } else if indexPath.row == 3 {
            navigationController?.pushViewController(CircleLoaderVC(), animated: true)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 100)
    }

}
