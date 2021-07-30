//
//  DrawViewController.swift
//  NoteDraw
//
//  Created by 18495524 on 7/28/21.
//

import UIKit

class DrawViewController: UIViewController {
    
    // MARK: - Dependencies
    
    var dataSource: DrawViewModel
    var delegate: HomeViewController?
    
    // MARK: - Init
    
    init(dataSource: DrawViewModel) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    lazy var canvas: CanvasView = {
        let imageEntity = self.delegate?.getSelectedImage()
        var image: UIImage?
        
        if let data = imageEntity?.data {
            image = UIImage(data: data)
        }
        
        let canvasSize = CGRect(
            origin: .zero,
            size: image?.size ?? CGSize(width: 300, height: 300)
        )
        let canvas = CanvasView(frame: canvasSize)
        canvas.delegate = self.delegate
        canvas.image = image
        
        canvas.setColor(dataSource.colors.first)
        canvas.setTool(dataSource.tools[dataSource.defaultTool])
        
        canvas.translatesAutoresizingMaskIntoConstraints = false
        return canvas
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        let contentSize = CGSize(width: canvas.frame.width, height: canvas.frame.height)
        
        sv.delegate = self
        
        sv.backgroundColor = .green
        sv.contentSize = contentSize
        
        sv.panGestureRecognizer.minimumNumberOfTouches = 2
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var colorsTableBackground: UIView = {
        let ctb = UIView()
        ctb.backgroundColor = .secondarySystemBackground
        ctb.layer.cornerRadius = 10
        ctb.isHidden = true
        ctb.translatesAutoresizingMaskIntoConstraints = false
        return ctb
    }()
    
    lazy var colorButtonBackground: UIView = {
        let bb = UIView()
        bb.backgroundColor = .secondarySystemBackground
        bb.layer.cornerRadius = 10
        bb.translatesAutoresizingMaskIntoConstraints = false
        return bb
    }()
    
    lazy var colorButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = dataSource.defaultColor
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(selectColor), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var colorsTable: UITableView = {
        let ct = UITableView(frame: .zero)
        ct.backgroundColor = .clear
        ct.separatorStyle = .none
        ct.register(ColorsTableDrawCell.self, forCellReuseIdentifier: "drawCell")
        ct.showsVerticalScrollIndicator = false
        ct.isHidden = true
        ct.isPagingEnabled = true
        ct.translatesAutoresizingMaskIntoConstraints = false
        return ct
    }()
    
    lazy var toolsCollection: UICollectionView = {
        let layout = CollectionFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 55, height: 50)
        layout.minimumLineSpacing = 25
        
        let tc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tc.register(ToolsCollectionDrawCell.self, forCellWithReuseIdentifier: ToolsCollectionDrawCell.cellId)
        tc.backgroundColor = .secondarySystemBackground
        tc.showsHorizontalScrollIndicator = false
        
        tc.translatesAutoresizingMaskIntoConstraints = false
        return tc
    }()
    
    // MARK: - View hooks

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Draw"
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(canvas)
        view.addSubview(colorsTableBackground)
        view.addSubview(colorButtonBackground)
        view.addSubview(colorButton)
        view.addSubview(colorsTable)
        view.addSubview(toolsCollection)
        
        colorsTable.dataSource = self
        colorsTable.delegate = self
        
        toolsCollection.dataSource = self
        toolsCollection.delegate = self
        
        setupNavigation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(scrollView.bounds.size)
        updateConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(item: dataSource.defaultTool, section: 0)
        toolsCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        canvas.clear()
    }
    
    private func updateConstraints() {
        centerScrollViewContent(scrollView)
        colorButton.layer.cornerRadius = colorButton.frame.height / 2
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: toolsCollection.topAnchor),
            
            colorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            colorButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            colorsTable.widthAnchor.constraint(equalToConstant: 40),
            colorsTable.heightAnchor.constraint(equalToConstant: 308),
            colorsTable.topAnchor.constraint(equalTo: colorButton.topAnchor, constant: -5),
            colorsTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            colorButtonBackground.widthAnchor.constraint(equalToConstant: 55),
            colorButtonBackground.heightAnchor.constraint(equalToConstant: 40),
            colorButtonBackground.topAnchor.constraint(equalTo: colorsTable.topAnchor),
            colorButtonBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -5),
            
            colorsTableBackground.widthAnchor.constraint(equalToConstant: 55),
            colorsTableBackground.heightAnchor.constraint(equalTo: colorsTable.heightAnchor),
            colorsTableBackground.topAnchor.constraint(equalTo: colorsTable.topAnchor),
            colorsTableBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -5),
            
            toolsCollection.heightAnchor.constraint(equalToConstant: 100),
            toolsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }

}




