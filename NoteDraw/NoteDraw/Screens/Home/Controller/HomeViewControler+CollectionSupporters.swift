//
//  HomeViewControler+CollectionSupporters.swift
//  NoteDraw
//
//  Created by 18495524 on 7/30/21.
//

import UIKit

// MARK: - Collection Delegate, Collection Data Source

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageEntity = frc.getImage(at: indexPath)
        guard let imageData = imageEntity.data, let image = UIImage(data: imageData) else { return }
        setSelectedImageIndex(indexPath)
        
        let previewViewController = ImagePreviewController(image: image, imageName: imageEntity.title ?? "")
        
        previewViewController.editCompletion = { [unowned self] in
            self.showDrawScreenForImage(at: indexPath)
        }
        previewViewController.renameCompletion = { [unowned self] in
            self.updateImageTitle(at: indexPath)
        }
        previewViewController.removeCompletion = { [unowned self] in
            self.showRemoveDialog(at: indexPath)
        }
        
        previewViewController.shareCompletion = { [unowned self] in
            self.showShareImageDialog(image: image)
        }
        
        present(previewViewController, animated: true, completion: nil)
    }
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = frc.sections else { return 0 }
        return sections[section].numberOfObjects
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageEntity = frc.object(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionCell.cellId, for: indexPath) as! ImagesCollectionCell
        
        let title = imageEntity.title ?? "new image"
        let image = imageEntity.data == nil ? UIImage() : UIImage(data: imageEntity.data!)
        cell.label.text = title
        cell.imageView.image = image
        cell.date = imageEntity.date

        return cell
    }
}
