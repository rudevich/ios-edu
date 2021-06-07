//
//  FirstViewController.swift
//  MakeDrawingAppsGreatAgain
//
//  Created by Вадим Аписов on 29.05.2021.
//

import UIKit

final class FirstViewController: UIViewController {
    private let collectionView: UICollectionView
    var selectedImage: UIImage?
    
    private var dataModel: CollectionViewDataModel
    private var isDefaultYOffsetSetted = false
    private var defaultYOffset: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        
        setupCollectionView()
        setupNavigationItem()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard !isDefaultYOffsetSetted else { return }
        
        isDefaultYOffsetSetted = !isDefaultYOffsetSetted
        
        defaultYOffset = collectionView.contentOffset.y
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.cellId)
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "You have \(dataModel.imagesArray.count) images"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(displayActionSheet))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .clear
        navigationItem.backButtonTitle = "Back"
    }
    
    private func setupConstraints() {
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: -1),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 1),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -1),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1)
        ]
        
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
    @objc private func displayActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let galleryIcon = UIImage(systemName: "photo.on.rectangle.angled")
        let gallery = UIAlertAction(title: "Photo library", style: .default) { [unowned self] _ in
            self.takeImageFromGallery()
        }
        gallery.setValue(galleryIcon, forKey: "image")
        gallery.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let drawIcon = UIImage(systemName: "hand.draw")
        let draw = UIAlertAction(title: "Draw", style: .default) { [unowned self] _ in
            self.selectedImage = nil
            self.pushSecondVC()
        }
        draw.setValue(drawIcon, forKey: "image")
        draw.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(gallery)
        actionSheet.addAction(draw)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc private func pushSecondVC() {
        let dataSource = DrawViewModel()
        let secondVC = ViewController(dataSource: dataSource)
        secondVC.delegate = self
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    init(dataModel: CollectionViewDataModel, collectionView: UICollectionView) {
        self.dataModel = dataModel
        self.collectionView = collectionView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            displayActionSheet()
        } else {
            guard let image = dataModel.imagesArray[indexPath.item],
                  let imageName = dataModel.titlesArray[indexPath.item] else { return }
            
            let showImageVC = ShowImageViewController(image: image, imageName: imageName)
            
            showImageVC.completion = { [unowned self] in
                self.chooseAnItem(indexPath.item)
            }
            
            present(showImageVC, animated: true, completion: nil)
        }
    }
    
    func chooseAnItem(_ index: Int) {
        self.selectedImage = dataModel.imagesArray[index]
        self.pushSecondVC()
    }
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.imagesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.cellId, for: indexPath) as! CustomCell

        cell.imageView.image = indexPath.item != 0 ? dataModel.imagesArray[indexPath.item] : .none
        cell.button.isHidden = indexPath.item != 0 ? true : false
        cell.label.text = dataModel.titlesArray[indexPath.item]

        return cell
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let defaultYOffset = defaultYOffset else { return }

        if collectionView.contentOffset.y > defaultYOffset + view.frame.width / 3 - 2 {
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = .black
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = .clear
        }
    }
}

extension FirstViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func takeImageFromGallery() {
        let sourceType: UIImagePickerController.SourceType = .photoLibrary
        
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        
        pickAnImage(image)
    }
    
    func saveImage(_ image: UIImage?) {
        guard self.selectedImage != nil else { return pickAnImage(image) }
        for (i, modelImage) in dataModel.imagesArray.enumerated() {
            if (self.selectedImage == modelImage) {
                dataModel.imagesArray[i] = image
                collectionView.reloadData()
                break;
            }
        }
    }
    
    func pickAnImage(_ image: UIImage?) {
        dismiss(animated: true, completion: nil)
        
        let alert = UIAlertController(title: "Enter image title", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let action = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            if alert.textFields?.first!.text == "" {
                self.appendImageToCollectionView(image: image, title: "Untitled")
            } else {
                self.appendImageToCollectionView(image: image, title: alert.textFields?.first!.text)
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func appendImageToCollectionView(image: UIImage?, title: String?) {
        dataModel.imagesArray.insert(image, at: 1)
        dataModel.titlesArray.insert(title, at: 1)
        
        collectionView.insertItems(at: [[0, 1]])
        
        navigationItem.title = "You have \(dataModel.imagesArray.count) images"
    }
}
