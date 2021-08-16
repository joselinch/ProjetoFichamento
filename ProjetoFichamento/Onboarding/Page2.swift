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
    let fakeImage = UIStackView()
    
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
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.textColor = UIColor(named: "BackgroundsTertiary")
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        startButton.backgroundColor = UIColor(named: "Color1Primary")
        startButton.setTitle("Let's Start", for: .normal)
        startButton.titleLabel?.textColor = UIColor(named: "BackgroundsPrimary")
        startButton.layer.cornerRadius = 6
        startButton.addTarget(self, action: #selector(startNext), for: .touchUpInside)
        
        view.backgroundColor = UIColor(named: "Color2Tertiary")
    }
    
    @objc func startNext(_ sender: UIButton) {
        guard let window = self.view.window else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "HomeStoryboard")
        window.rootViewController = nextView
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: nil)
        
        UserDefaults.standard.set(true, forKey: "hasFinishedOnboarding")
    }
    
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(fakeImage)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: imageView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 90),
            titleLabel.widthAnchor.constraint(equalToConstant: 260),
            
            startButton.heightAnchor.constraint(equalToConstant: 44),
            startButton.widthAnchor.constraint(equalToConstant: 329),
            startButton.bottomAnchor.constraint(equalToSystemSpacingBelow: fakeImage.topAnchor, multiplier: 15)
            
        ])
    }
}
