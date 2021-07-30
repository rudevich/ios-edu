//
//  CollectionView.swift
//  colorcontur
//
//  Created by 18495524 on 7/9/21.
//

import UIKit

final class CollectionView: UICollectionView {
    private let layout: UICollectionViewLayout = {
        let bigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0))
        let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)
        bigItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let doubleSmallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/2))
        let doubleSmallItem = NSCollectionLayoutItem(layoutSize: doubleSmallItemSize)
        doubleSmallItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let doubleSmallItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let doubleSmallItemGroup = NSCollectionLayoutGroup.vertical(layoutSize: doubleSmallItemGroupSize, subitem: doubleSmallItem, count: 2)
        
        let mosaicGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2/6))
        
        let leftMosaicGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mosaicGroupSize, subitems: [bigItem, doubleSmallItemGroup])
        
        let rightMosaicGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mosaicGroupSize, subitems: [doubleSmallItemGroup, bigItem])
        
        let tripleSmallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let tripleSmallItem = NSCollectionLayoutItem(layoutSize: tripleSmallItemSize)
        tripleSmallItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let tripleSmallItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/6))
        let tripleSmallItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: tripleSmallItemGroupSize, subitem: tripleSmallItem, count: 3)
        
        let jointGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2.0))
        let jointGroup = NSCollectionLayoutGroup.vertical(layoutSize: jointGroupSize, subitems: [tripleSmallItemGroup, leftMosaicGroup, tripleSmallItemGroup, rightMosaicGroup])
        
        let section = NSCollectionLayoutSection(group: jointGroup)
                
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
