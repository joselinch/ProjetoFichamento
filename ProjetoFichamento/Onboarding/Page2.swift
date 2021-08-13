//
//  Page2.swift
//  ProjetoFichamento
//
//  Created by Julia Silveira de Souza on 13/08/21.
//

import UIKit

class Page2: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let startButton = UIButton()
    
    
    init(imageName: String, titleText: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        startButton.title(for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension Page2 {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        //stackView.alignment = .center
        stackView.distribution = .equalCentering
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .top
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.textColor = UIColor(named: "BackgroundsTertiary")
        
        startButton.backgroundColor = UIColor(named: "Color1Primary")
        
        view.backgroundColor = UIColor(named: "Color2Tertiary")
    }
    
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(startButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
}

