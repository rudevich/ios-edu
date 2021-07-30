//
//  ViewController.swift
//  colorcontur
//
//  Created by 18495524 on 7/9/21.
//

import UIKit

class LocalListViewController: UIViewController {
    
    var selected: UIImage?
    
    var dataModel: LocalImagesDataModel
    var collectionView: UICollectionView
    
    
    lazy var detectViewController: ColoringViewController = {
        let vc = ColoringViewController()
        return vc
    }()
    
    lazy var pickImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Pick a pic bro", for: .normal)
        button.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        return button
    }()
    
    @objc func showImagePicker() {
//        self.selected = UIImage(contentsOfFile: Bundle.main.path(forResource: "sample", ofType: "jpg")!)
//        navigationController?.pushViewController(detectViewController, animated: true)
        self.chooseImageSourceDialog()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose a pic to color"
        
        view.backgroundColor = .yellow
        
        view.addSubview(pickImageButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraints()
    }
    
    func updateConstraints() {
        NSLayoutConstraint.activate([
            pickImageButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            pickImageButton.trailingAnchor.constraint(equalTo:view.centerXAnchor, constant: 100),
            pickImageButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 0),
            pickImageButton.bottomAnchor.constraint(equalTo:view.centerYAnchor, constant: 50),
        ])
    }
    
    init(dataModel: LocalImagesDataModel, collectionView: UICollectionView) {
        self.dataModel = dataModel
        self.collectionView = collectionView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: Image picker
extension LocalListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func chooseImageSourceDialog() {
        let gallery = UIAlertAction(title: "Load contour from gallery", style: .default) { [unowned self] _ in
            self.showGallery()
        }
        gallery.setValue(UIImage(systemName: "photo.on.rectangle.angled"), forKey: "image")
        gallery.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        
        let draw = UIAlertAction(title: "Draw a contour", style: .default) { [unowned self] _ in
            self.selected = nil
            self.showDrawScreen()
//            reset selectedImage and go to drawing screen
        }
        draw.setValue(UIImage(systemName: "hand.draw"), forKey: "image")
        draw.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let actions = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actions.addAction(gallery)
        actions.addAction(draw)
        actions.addAction(cancel)
        
        present(actions, animated: true, completion: nil)
    }
    
    private func showDrawScreen() {
        Router.route?.push("draw", animated: true)
    }
    
    private func showGallery() {
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
        dismiss(animated: true, completion: nil)
        Router.route?.setCurrentImage(image)
        Router.route?.push("coloring", animated: true)
    }
    
}

