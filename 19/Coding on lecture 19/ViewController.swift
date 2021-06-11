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
    
    lazy var button: UIButton = {
        let button = UIButton()
        
        button.setTitle("pick", for: .normal)
        button.backgroundColor = .purple
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        return imagePicker
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
        view.addSubview(button)
        view.addSubview(slider)
        
        self.navigationItem.title = "Choose filter"
        
        let settings = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(settingsTapped))
        navigationItem.rightBarButtonItems = [settings]
        setupConstraints()
        
        print(CIFilter.filterNames(inCategory: kCICategoryBuiltIn))
//        "CIBlendWithRedMask", "CIBloom", "CIBokehBlur", "CIBoxBlur", "CIBumpDistortion", "CIBumpDistortionLinear"
        
        slider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    
    private func setupConstraints() {
        let imageViewConstraints = [
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10)
        ]
        
        let buttonConstraints = [
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ]
        
        
        let sliderConstraints = [
            slider.widthAnchor.constraint(equalToConstant: 100),
            slider.heightAnchor.constraint(equalToConstant: 100),
            slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(sliderConstraints)
    }
    
    @objc private func buttonTapped() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func doFilter(_ image: UIImage) -> UIImage {
        //        "CIBlendWithRedMask", "CIBloom", "CIBokehBlur", "CIBoxBlur", "CIBumpDistortion", "CIBumpDistortionLinear"
        if let filter = CIFilter(name: "CIBloom") {
            let ciImage = CIImage(image: image)
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            filter.setValue(55, forKey: kCIInputIntensityKey)
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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        imageView.image = doFilter(image ?? UIImage())
        
        dismiss(animated: true, completion: nil)
    }
}

