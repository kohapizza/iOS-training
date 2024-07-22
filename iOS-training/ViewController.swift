//
//  ViewController.swift
//  iOS-training
//
//  Created by 佐伯小遥 on 2024/07/20.
//

import UIKit

class ViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.green
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var redLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.textColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var blueLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.textColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.view.addSubview(imageView)
        self.view.addSubview(redLabel)
        self.view.addSubview(blueLabel)
        self.view.addSubview(rightButton)
        self.view.addSubview(leftButton)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor), // 縦・横幅を等しくする
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: blueLabel.intrinsicContentSize.height/2),
            
            redLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
            redLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            redLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            
            blueLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
            blueLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            blueLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            
            leftButton.topAnchor.constraint(equalTo: blueLabel.bottomAnchor, constant: 80),
            leftButton.leadingAnchor.constraint(equalTo: blueLabel.leadingAnchor),
            leftButton.centerXAnchor.constraint(equalTo: blueLabel.centerXAnchor),
            
            rightButton.topAnchor.constraint(equalTo: redLabel.bottomAnchor, constant: 80),
            rightButton.trailingAnchor.constraint(equalTo: redLabel.trailingAnchor),
            rightButton.centerXAnchor.constraint(equalTo: redLabel.centerXAnchor)
        ])

        
        
    }
    
    

}

