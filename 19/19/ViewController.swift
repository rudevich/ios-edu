//
//  ViewController.swift
//  Coding on lecture 19
//
//  Created by Alexander Rudevich on 04.06.2021.
//

import UIKit



class ViewController: UIViewController {
    
    var settingsViewController: UIViewController?
        
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 3
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let context = CIContext()
    
    @objc func sliderChanged() {
        imageView.transform = CGAffineTransform(scaleX: CGFloat(slider.value), y: CGFloat(slider.value))
    }
    
    @objc func settingsTapped() {
        guard let settingsViewController = self.settingsViewController else { return }
        navigationController?.show(settingsViewController, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewController = SettingsViewController()
        
        view.backgroundColor = .cyan
        view.addSubview(imageView)
        view.addSubview(slider)
        
        self.navigationItem.title = "Choose filter"
        
        let settings = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(settingsTapped))
        navigationItem.rightBarButtonItems = [settings]
        setupConstraints()
        
//        print(CIFilter.filterNames(inCategory: kCICategoryBuiltIn))
//        "CIBlendWithRedMask", "CIBloom", "CIBokehBlur", "CIBoxBlur", "CIBumpDistortion", "CIBumpDistortionLinear"
        
        slider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let settingsController = self.settingsViewController as? SettingsViewControllerOut else { return }
        imageView.image = doFilter(
            settingsController.getImage(),
            filterName: settingsController.getFilterName(),
            intensity: settingsController.getIntensity()
        )
    }
    
    private func setupConstraints() {
        let imageViewConstraints = [
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        let sliderConstraints = [
            slider.widthAnchor.constraint(equalToConstant: 100),
            slider.heightAnchor.constraint(equalToConstant: 100),
            slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(sliderConstraints)
    }
    
    func doFilter(_ imageOptional: UIImage?, filterName: String, intensity: Float) -> UIImage? {
        //        "CIBlendWithRedMask", "CIBloom", "CIBokehBlur", "CIBoxBlur", "CIBumpDistortion", "CIBumpDistortionLinear"
        guard let image = imageOptional else { return imageOptional}
        
        return DispatchQueue(label: "air-mainFilter").sync {
            if let filter = CIFilter(name: "CIBloom") {
                let ciImage = CIImage(image: image)
                filter.setValue(ciImage, forKey: kCIInputImageKey)
                filter.setValue(intensity, forKey: kCIInputIntensityKey)
                if let filteredImage = filter.outputImage {
                    if let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent) {
                        let returnImage = UIImage(cgImage: cgImage)
                        return returnImage
                    }
                }
            }
            return image
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
