//
//  ViewController.swift
//  26
//
//  Created by 18495524 on 6/23/21.
//


import CoreData
import UIKit

class ViewController: UIViewController {
    
    private let stack = AnimalsStack.shared
    
    lazy var label1: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        return label
    }()
    lazy var label2: UILabel = {
        let label = UILabel()
        label.text = "Возраст"
        return label
    }()
    lazy var label3: UILabel = {
        let label = UILabel()
        label.text = "Пол"
        return label
    }()
    lazy var text1: UITextField = {
        let text = UITextField()
        return text
    }()
    lazy var text2: UITextField = {
        let text = UITextField()
        return text
    }()
    lazy var text3: UITextField = {
        let text = UITextField()
        return text
    }()
    lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("add", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(addHumanTapped), for: .touchUpInside)
        return button
    }()
    lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("print", for: .normal)
        button.addTarget(self, action: #selector(printHumans), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle("clear", for: .normal)
        button.addTarget(self, action: #selector(clearHumans), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    @objc func clearHumans() {
        print("clear Humans")
        let context = stack.container.viewContext
    
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Human")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try? stack.container.persistentStoreCoordinator.execute(deleteRequest, with: context)
     
    }
    
    @objc func printHumans() {
        print("print Humans")
        let context = stack.container.viewContext
        context.performAndWait {
            let request = NSFetchRequest<Human>(entityName: "Human")
            request.sortDescriptors = [.init(key: "age", ascending: true)]
//            request.predicate = .init(format: "name == 'Fish numba 1'")
            let result = try? request.execute()
            result?.forEach {
                print("name: \($0.name) age: \($0.age)")
            }
            try? context.save()
        }
    }
    
    @objc func addHumanTapped() {
        print("added Human")
        let context = stack.container.viewContext
        context.performAndWait {
            let human = Human(context: context)
            human.name = text1.text ?? ""
            var age: Int = Int(text2.text ?? "") ?? 0
            human.age = Int16(age) ?? 0
            human.gender = text3.text == nil ? false : true
            try? context.save()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(text1)
        stackView.addArrangedSubview(label2)
        stackView.addArrangedSubview(text2)
        stackView.addArrangedSubview(label3)
        stackView.addArrangedSubview(text3)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        view.addSubview(stackView)
        
        view.backgroundColor = .white
    }

}

