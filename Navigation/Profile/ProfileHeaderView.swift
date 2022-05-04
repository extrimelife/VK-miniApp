//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let image: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "square"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    private let label: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.attributedText = NSMutableAttributedString(string: "Hipster Cat")
        textLabel.textColor = .black
        textLabel.backgroundColor = .clear
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return textLabel
    }()
    
    private let text: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Waiting for something"
        textView.textColor = .gray
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    
    private let textField: UITextField = {
        let fieldText = UITextField()
        fieldText.translatesAutoresizingMaskIntoConstraints = false
        fieldText.text = ""
        fieldText.backgroundColor = .white
        fieldText.layer.cornerRadius = 12
        fieldText.layer.borderWidth = 1
        fieldText.placeholder = "Set your status..."
        fieldText.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: fieldText.frame.height))
        fieldText.leftViewMode = .always
        fieldText.layer.borderColor = UIColor.black.cgColor
        fieldText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        fieldText.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return fieldText
    }()
    
    private let setupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Set status", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()
    
    
    @objc private func tapAction() {
        text.text = statusText
        print(text.text ?? "")
    }
    
    @objc private func statusTextChanged() {
        statusText = textField.text ?? ""
        
    }
    
    private func setupLayout() {
        [image, label, text, setupButton, textField].forEach { self.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            //constrain UIimage
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100),
            label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            
            //constrain UIlabel
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 30),
            
            //constrain UItext
            text.topAnchor.constraint(equalTo: label.bottomAnchor),
            text.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            text.heightAnchor.constraint(equalToConstant: 40),
            
            //constrain UIbutton
            setupButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            setupButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setupButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setupButton.heightAnchor.constraint(equalToConstant: 50),
            
            //constrain UItextfield
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 27),
            textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}

