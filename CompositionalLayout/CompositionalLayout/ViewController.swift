//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by 박진성 on 2023/05/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private let images: [UIImage] = Array(1 ... 11).map { UIImage(named: String($0))! }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.collectionViewLayout = createLayout()
    }


    private func createLayout() -> UICollectionViewCompositionalLayout {
        // item
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5), height: .fractionalHeight(1), spacing: 1)
        
        let fullItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 1)
        
        // Group
        let verticalGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(0.5), height: .fractionalHeight(1), item: fullItem, count: 5)
        
        let horizontalGroup = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.6), items: [item, verticalGroup])
        
        let mainItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.4), spacing: 1)
        let mainGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(1), items: [mainItem, horizontalGroup])
        
        // Section
        let section = NSCollectionLayoutSection(group: mainGroup)
        
        // return
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        cell.setup(image: images[indexPath.row])
        return cell
        
    }
    
    
}

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    func setup(image: UIImage) {
        cellImageView.image = image
    }
    
    
    
}
