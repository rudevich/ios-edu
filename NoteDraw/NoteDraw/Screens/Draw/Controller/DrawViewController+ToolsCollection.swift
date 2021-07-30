//
//  DrawViewControllerToolsCollection.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

// MARK: - CollectonView
extension DrawViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = view.convert(toolsCollection.center, to: toolsCollection)
        guard let index = toolsCollection.indexPathForItem(at: center) else { return }
        canvas.setTool(dataSource.tools[index.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        canvas.setTool(dataSource.tools[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.tools.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToolsCollectionDrawCell.cellId, for: indexPath) as? ToolsCollectionDrawCell else { return UICollectionViewCell()}
        cell.configure(model: dataSource.toolsIcons[indexPath.row]!)
        return cell
    }
}
