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
    private let cellColors = [UIColor.red, .green, .blue]
    private let textLabels = ["Pan And Animate", "CADisplayLink", "Chain Animation"]
    private let textColors = [UIColor.black, .black, .white]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Main Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellColors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = cellColors[indexPath.row]
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            ])
        
        title.text = textLabels[indexPath.row]
        title.textColor = textColors[indexPath.row]

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            navigationController?.pushViewController(PanAnimateVC(), animated: true)
        } else if indexPath.row == 1 {
            navigationController?.pushViewController(CounterVC(), animated: true)
        } else if indexPath.row == 2 {
            navigationController?.pushViewController(ChainAnimateVC(), animated: true)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 100)
    }

}
