//
//  ViewController.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    // MARK: - Network service
    var networkService: NetworkService
    
    private let spinner = SpinnerViewController()
    
    var isLoading = false {
        didSet {
            guard oldValue != isLoading else { return }
            setLoading(isLoading)
        }
    }
    
    func setLoading(_ loading: Bool) {
        if (loading) {
            self.addChild(spinner)
            spinner.view.frame = self.view.frame
            view.addSubview(spinner.view)
            spinner.didMove(toParent: self)
        } else {
            spinner.willMove(toParent: nil)
            spinner.view.removeFromSuperview()
            spinner.removeFromParent()
        }
    }
    
    // MARK: - CoreData stuff
    private let coreDataStack = Container.shared.coreDataStack
    
    lazy var frc: FetchImagesResultsController = {
        let request = NSFetchRequest<Images>(entityName: "Images")
        request.sortDescriptors = [.init(key: "date", ascending: false)]
        let frc = FetchImagesResultsController(
            fetchRequest: request,
            managedObjectContext: Container.shared.coreDataStack.backgroundContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        frc.collectionView = imagesCollection
        frc.delegate = frc
        return frc
    }()
    
    // MARK: - own stuff
    
    var selectedImageIndex: IndexPath?
    
    lazy var imagesCollection: UICollectionView = {
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(ImagesCollectionCell.self, forCellWithReuseIdentifier: ImagesCollectionCell.cellId)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - init
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigation()
        view.addSubview(imagesCollection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? frc.performFetch()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraints()
    }
    
    private func updateConstraints() {
        NSLayoutConstraint.activate([
            imagesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesCollection.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            imagesCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
    }
    
    // MARK: - own methods
    
    func saveImageWithTitle(_ image: UIImage?) {
        setImageTitle() { [unowned self] title in
            guard let index = getSelectedImageIndex() else {
                return frc.insertImage(title: title, image: image)
            }
            frc.updateImage(at: index, title: title, image: image)
        }
    }
    
    func updateImageTitle(at index: IndexPath) {
        setImageTitle() { [unowned self] title in
            frc.updateImage(at: index, title: title, image: nil)
        }
    }
    
    func setImageTitle(completion: @escaping ((_ title: String?) -> Void)) {
        dismiss(animated: true, completion: nil)
        
        let alert = UIAlertController(title: "Title", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { [unowned self] field in
            let index = getSelectedImageIndex()
            var title = ""
            if let index = index {
                title = frc.object(at: index).title ?? ""
            }
            field.text = title
       })
        
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            completion(alert.textFields?.first?.text)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Foreign screens
    
    func showDrawScreenForImage(at index: IndexPath? = nil) {
        if (index == nil) {
            resetSelectedImageIndex()
        }
        let drawScreen = DrawViewController(dataSource: DrawViewModel())
        drawScreen.delegate = self
        navigationController?.pushViewController(drawScreen, animated: true)
    }
    
    func showRemoveDialog(at index: IndexPath) {
        let alert = UIAlertController(title: "Remove?", message: "Image will be removed", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [unowned self] (action: UIAlertAction!) in
            frc.removeImage(at: index)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              
        }))

        present(alert, animated: true, completion: nil)
    }

    func showShareImageDialog(image: UIImage) {
        let imageShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
}





// MARK: - manage selected image/id

extension HomeViewController {
    func resetSelectedImageIndex() {
        selectedImageIndex = nil
    }
    
    func setSelectedImageIndex(_ indexPath: IndexPath) {
        selectedImageIndex = indexPath
    }
    
    func getSelectedImageIndex() -> IndexPath? {
        return selectedImageIndex
    }
    
    func getSelectedImage() -> Images? {
        guard let index = selectedImageIndex else { return nil }
        return frc.getImage(at: index)
    }
}
