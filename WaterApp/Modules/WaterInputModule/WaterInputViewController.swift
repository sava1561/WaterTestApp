//
//  WaterInputViewController.swift
//  WaterApp
//
//  Created by 18745092 on 01.03.2022.
//

import UIKit

protocol IWaterInputView: AnyObject {
    func displayAlertWithTitle(_ title: String, description: String)
    func displayResultsWithDataSource(_ dataSource: UITableViewDataSource?)
}

final class WaterInputViewController: UIViewController, IWaterInputView {
    private var controller: IWaterInputController?
    private lazy var xBottleTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "First bottle capacity(X)"
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    private lazy var yBottleTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Second bottle capacity(Y)"
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    private lazy var neededWaterTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Water to measure(Z)"
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    private lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapCalculate), for: .touchUpInside)
        button.setTitle("Calculate", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private lazy var resultsTable: UITableView = .init()
    
    init(controller: IWaterInputController) {
        self.controller = controller
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupViews()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calculateButton.layer.cornerRadius = calculateButton.frame.height / 2
    }
    
    private func setupViews() {
        [
            xBottleTextfield,
            yBottleTextfield,
            neededWaterTextfield,
            calculateButton,
            resultsTable
        ].forEach({
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    /**
     I would prefer using smthing like SnapKit, but for test project I decided to not use pods for easier setup from your side
     */
    private func setupLayout() {
        [
            xBottleTextfield.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            xBottleTextfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            xBottleTextfield.widthAnchor.constraint(equalToConstant: 230),
            xBottleTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            yBottleTextfield.topAnchor.constraint(equalTo: self.xBottleTextfield.bottomAnchor, constant: 15),
            yBottleTextfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            yBottleTextfield.widthAnchor.constraint(equalTo: xBottleTextfield.widthAnchor),
            yBottleTextfield.heightAnchor.constraint(equalTo: xBottleTextfield.heightAnchor),
            
            neededWaterTextfield.topAnchor.constraint(equalTo: self.yBottleTextfield.bottomAnchor, constant: 15),
            neededWaterTextfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            neededWaterTextfield.widthAnchor.constraint(equalTo: yBottleTextfield.widthAnchor),
            neededWaterTextfield.heightAnchor.constraint(equalTo: yBottleTextfield.heightAnchor),
            
            calculateButton.topAnchor.constraint(equalTo: self.neededWaterTextfield.bottomAnchor, constant: 15),
            calculateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            calculateButton.widthAnchor.constraint(equalToConstant: 270),
            calculateButton.heightAnchor.constraint(equalToConstant: 30),
            
            resultsTable.topAnchor.constraint(equalTo: self.calculateButton.bottomAnchor, constant: 30),
            resultsTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            resultsTable.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            resultsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
        ].forEach({
            $0.isActive = true
        })
    }
    
    @objc private func didTapCalculate() {
        controller?.calculateWater(
            xValueStr: xBottleTextfield.text ?? "",
            yValueStr: yBottleTextfield.text ?? "",
            neededCapacityStr: neededWaterTextfield.text ?? "")
    }

    func displayResultsWithDataSource(_ dataSource: UITableViewDataSource?) {
        self.resultsTable.dataSource = dataSource
        resultsTable.reloadData()
    }
    
    func displayAlertWithTitle(_ title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .destructive, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
