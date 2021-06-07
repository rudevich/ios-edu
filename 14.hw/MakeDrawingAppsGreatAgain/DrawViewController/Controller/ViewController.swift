//  ViewController.swift
//  Lesson15-16
//
//  Created by Владислав Галкин on 29.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var dataSource: DrawViewModel
    var delegate: FirstViewController?
    
    // MARK: - Init
    
    init(dataSource: DrawViewModel) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Properties
    
    let defaultToolIndex = 3 // freedraw
    var selectedColor: UIColor?
    
    // MARK: - UIComponents
    
    lazy var tableViewBackground: UIView = {
        let tvb = UIView()
        tvb.backgroundColor = .secondarySystemBackground
        tvb.layer.cornerRadius = 10
        tvb.isHidden = true
        tvb.translatesAutoresizingMaskIntoConstraints = false
        
        return tvb
    }()
    
    lazy var buttonBackground: UIView = {
        let bb = UIView()
        bb.backgroundColor = .secondarySystemBackground
        bb.layer.cornerRadius = 10
        bb.translatesAutoresizingMaskIntoConstraints = false
        
        return bb
    }()
    
    lazy var colorButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(selectColor), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TableViewDrawCell.self, forCellReuseIdentifier: "drawCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        tableView.isPagingEnabled = true
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = CollectionFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 55, height: 50)
        layout.minimumLineSpacing = 25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionVIewDrawCell.self, forCellWithReuseIdentifier: "drawBar")
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy private var gradientView: GradientView = {
        let gradientView = GradientView()
        
        gradientView.colors = [
            UIColor.secondarySystemBackground,
            UIColor.secondarySystemBackground.withAlphaComponent(0),
            UIColor.secondarySystemBackground.withAlphaComponent(0),
            UIColor.secondarySystemBackground
        ]
        gradientView.isUserInteractionEnabled = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        return gradientView
    }()
    
    lazy var canvas: CanvasView = {
        let canvas = CanvasView(frame: self.view.frame)
        canvas.delegate = self.delegate
        canvas.setColor(dataSource.modelTableColor.first)
        canvas.setTool(dataSource.availableTools[defaultToolIndex])
        canvas.translatesAutoresizingMaskIntoConstraints = false
        return canvas
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(canvas)
        view.addSubview(tableViewBackground)
        view.addSubview(buttonBackground)
        view.addSubview(colorButton)
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(gradientView)
        tableView.dataSource = self
        tableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        addButtonsToNavigation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraint()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(item: defaultToolIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - Private methods
    
    private func addButtonsToNavigation() {
        let undo = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(canvasUndo))
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(canvasSave))
        
        undo.isEnabled = false
        save.isEnabled = false
        
        canvas.shapes.completion = {
            undo.isEnabled = $0
            save.isEnabled = $0
        }
        
        navigationItem.rightBarButtonItems = [undo, save].reversed()
    }
    
    @objc private func canvasClear() {
        canvas.clear()
    }
    
    @objc private func canvasUndo() {
        canvas.undo()
    }
    
    @objc private func canvasSave() {
        canvas.save()
    }
    
    private func updateConstraint() {
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.layer.cornerRadius = colorButton.frame.height / 2
        tableView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -145),
            colorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            colorButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            tableView.widthAnchor.constraint(equalToConstant: 40),
            tableView.heightAnchor.constraint(equalToConstant: 308),
            tableView.topAnchor.constraint(equalTo: colorButton.topAnchor, constant: -5),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            buttonBackground.widthAnchor.constraint(equalToConstant: 55),
            buttonBackground.heightAnchor.constraint(equalToConstant: 40),
            buttonBackground.topAnchor.constraint(equalTo: tableView.topAnchor),
            buttonBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -5),
            tableViewBackground.widthAnchor.constraint(equalToConstant: 55),
            tableViewBackground.heightAnchor.constraint(equalTo: tableView.heightAnchor),
            tableViewBackground.topAnchor.constraint(equalTo: tableView.topAnchor),
            tableViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -5),
            collectionView.heightAnchor.constraint(equalToConstant: 145),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.widthAnchor.constraint(equalTo: collectionView.widthAnchor),
            gradientView.heightAnchor.constraint(equalTo: collectionView.heightAnchor),
            gradientView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            gradientView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
    
    @objc private func selectColor() {
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        tableView.isHidden = false
        colorButton.isHidden = true
        tableViewBackground.isHidden = false
        buttonBackground.isHidden = true
    }
}

// MARK: - TableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedColor = dataSource.modelTableColor.remove(at: indexPath.row)
        dataSource.modelTableColor.insert(selectedColor!, at: 0)
        tableView.reloadData()
        tableView.isHidden = true
        colorButton.backgroundColor = selectedColor
        colorButton.isHidden = false
        tableViewBackground.isHidden = true
        buttonBackground.isHidden = false
        tableView.isHidden = true
        
        canvas.setColor(selectedColor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.modelTableColor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "drawCell", for: indexPath) as? TableViewDrawCell else { return UITableViewCell()}
        cell.configure(model: dataSource.modelTableColor[indexPath.row])
        return cell
    }
}

// MARK: - CollectonView
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = self.view.convert(self.collectionView.center, to: self.collectionView)
        guard let index = collectionView.indexPathForItem(at: center) else { return }
        canvas.setTool(dataSource.availableTools[index.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        canvas.setTool(dataSource.availableTools[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.modelCollectionShapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawBar", for: indexPath) as? CollectionVIewDrawCell else { return UICollectionViewCell()}
        cell.configure(model: dataSource.modelCollectionShapes[indexPath.row]!)
        return cell
    }
}
