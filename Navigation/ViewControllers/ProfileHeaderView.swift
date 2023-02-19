//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String?
    
    private let blackView: UIView = {
        let viewBlack = UIView()
        viewBlack.translatesAutoresizingMaskIntoConstraints = false
        viewBlack.alpha = 0
        viewBlack.backgroundColor = .black
        viewBlack.frame = UIScreen.main.bounds
        return viewBlack
    }()
    
    private lazy var buttonBlackView: UIButton = {
        let buttonView = UIButton()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.setImage(UIImage(systemName: "xmark"), for: .normal)
        buttonView.tintColor = .systemGray4
        buttonView.alpha = 0
        buttonView.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return buttonView
    }()
    
    
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
    
    
    private lazy var textField: UITextField = {
        let fieldText = UITextField()
        fieldText.translatesAutoresizingMaskIntoConstraints = false
        fieldText.text = ""
        fieldText.backgroundColor = .white
        fieldText.layer.cornerRadius = 12
        fieldText.layer.borderWidth = 1
        fieldText.clearButtonMode = .whileEditing
        fieldText.placeholder = "Set your status..."
        fieldText.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: fieldText.frame.height))
        fieldText.leftViewMode = .always
        fieldText.layer.borderColor = UIColor.black.cgColor
        fieldText.font = UIFont.systemFont(ofSize: 15)
        fieldText.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return fieldText
    }()
    
    private lazy var setupButton: UIButton = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupGesture()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Внедряю проверку на пустой textField при установке статуса!
    @objc private func tapAction() {
        if textField.text == "" {
            textField.attributedPlaceholder = NSAttributedString(string: "Cannot be empty...",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
        } else if textField.text != "" {
            textField.attributedPlaceholder = NSAttributedString(string: "Set your status...",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            text.text = statusText
           // print(text.text ?? "")
            
        }
    }
    
    @objc private func statusTextChanged() {
        statusText = textField.text ?? ""
        
    }
    
    // Присваиваю констрейнты к переменным чтобы констрейнты использовать для анимации
    private var topImage = NSLayoutConstraint()
    private var leadingImage = NSLayoutConstraint()
    private var widthImage = NSLayoutConstraint()
    private var heightImage = NSLayoutConstraint()
    
    
    private func setupLayout() {
        
        [image, label, text, setupButton, textField].forEach { self.addSubview($0) }
        
        // Задаю отдельно констрейнты для UiImage чтобы сделать анимацию ниже
        topImage = image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        leadingImage = image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        widthImage = image.widthAnchor.constraint(equalToConstant: 100)
        heightImage = image.heightAnchor.constraint(equalToConstant: 100)
        
        
        NSLayoutConstraint.activate([
            
            // constraint imageView
            topImage, leadingImage, widthImage, heightImage,
            
            //constrain UIlabel
            label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 130),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 30),
            
            //constrain UItext
            text.topAnchor.constraint(equalTo: label.bottomAnchor),
            text.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            text.heightAnchor.constraint(equalToConstant: 40),
            
            //constrain UIbutton
            setupButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            setupButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setupButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setupButton.heightAnchor.constraint(equalToConstant: 50),
            setupButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            //constrain UItextfield
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 27),
            textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc private func actionTap() {
        addSubview(blackView)
        addSubview(buttonBlackView)
        bringSubviewToFront(image)
        
        
        NSLayoutConstraint.activate([
            buttonBlackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            buttonBlackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            buttonBlackView.widthAnchor.constraint(equalToConstant: 30),
            buttonBlackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.blackView.alpha = 0.8
            self.image.layer.cornerRadius = 0
            self.topImage.constant = 100
            self.leadingImage.constant = 0
            self.widthImage.constant = UIScreen.main.bounds.width
            self.heightImage.constant = UIScreen.main.bounds.width
            self.layoutIfNeeded()
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.buttonBlackView.alpha = 1
            }
        }
    }
    
    @objc private func cancelAction() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.buttonBlackView.alpha = 0
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.image.layer.cornerRadius = 50
                self.topImage.constant = 0
                self.leadingImage.constant = 16
                self.widthImage.constant = 100
                self.heightImage.constant = 100
                self.blackView.alpha = 0
                self.layoutIfNeeded()
            }
        }
        
    }
}







