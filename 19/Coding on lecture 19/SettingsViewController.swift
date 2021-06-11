//
//  SecondViewController.swift
//  Coding on lecture 19
//
//  Created by Alexander Rudevich on 04.06.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var settings = [String: String]()
    
    lazy var filterNames:[String] = {
        let names = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        settings["filter"] = names[0]
        return names
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layoutMargins.bottom = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.backgroundColor = .red
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var sliderLabel: UILabel = {
        let sliderLabel = UILabel()
        sliderLabel.backgroundColor = .green
        sliderLabel.text = "Intensity:"
        return sliderLabel
    }()
    
    lazy var buttonImagePicker: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Pick an image", for: .normal)
        return button
    }()
    
    lazy var selectFilter: UIPickerView = {
        let select = UIPickerView()
        select.backgroundColor = .purple
        select.delegate = self
        select.dataSource = self
        return select
    }()
    
    @objc func sliderChanged() {
        settings["intensity"] = "\(slider.value)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        navigationItem.title = "Settings"
        
        
        
        stackView.addArrangedSubview(sliderLabel)
        stackView.addArrangedSubview(slider)
        stackView.addArrangedSubview(selectFilter)
        stackView.addArrangedSubview(buttonImagePicker)
        view.addSubview(stackView)
        
        selectFilter.selectRow(10, inComponent: 0, animated: false)
        
        sliderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonImagePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CIFilter.localizedName(forFilterName: filterNames[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let localized = CIFilter.localizedName(forFilterName: filterNames[row])
        settings["filter"] = filterNames[row]
    }
}
