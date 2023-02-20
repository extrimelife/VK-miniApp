//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    // MARK: - Private properties
    
    private var statusText: String?
    
    private let blackView: UIView = {
        let viewBlack = UIView()
        viewBlack.translatesAutoresizingMaskIntoConstraints = false
        viewBlack.alpha = 0
        viewBlack.backgroundColor = .black
        viewBlack.frame = UIScreen.main.bounds
        return viewBlack
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "square"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.attributedText = NSMutableAttributedString(string: "Hipster Cat")
        nameLabel.textColor = .black
        nameLabel.backgroundColor = .clear
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
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
    
    private lazy var crossButton: UIButton = {
        let crossButton = UIButton()
        crossButton.translatesAutoresizingMaskIntoConstraints = false
        crossButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        crossButton.tintColor = .systemGray4
        crossButton.alpha = 0
        crossButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return crossButton
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
    
    // Присваиваю констрейнты к переменным чтобы констрейнты использовать для анимации
    private var topImage = NSLayoutConstraint()
    private var leadingImage = NSLayoutConstraint()
    private var widthImage = NSLayoutConstraint()
    private var heightImage = NSLayoutConstraint()
    
    
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
            print(text.text ?? "")
        }
    }
    
    @objc private func statusTextChanged() {
        statusText = textField.text ?? ""
        
    }
    
    private func setupLayout() {
        [imageView, nameLabel, text, setupButton, textField].forEach { self.addSubview($0) }
        
        // Задаю отдельно констрейнты для UiImage чтобы сделать анимацию ниже
        topImage = imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        leadingImage = imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        widthImage = imageView.widthAnchor.constraint(equalToConstant: 100)
        heightImage = imageView.heightAnchor.constraint(equalToConstant: 100)
        
        
        NSLayoutConstraint.activate([
            topImage, leadingImage, widthImage, heightImage,
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 130),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            text.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            text.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            text.heightAnchor.constraint(equalToConstant: 40),
            
            setupButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            setupButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setupButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setupButton.heightAnchor.constraint(equalToConstant: 50),
            setupButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 27),
            textField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func actionTap() {
        addSubview(blackView)
        addSubview(crossButton)
        bringSubviewToFront(imageView)
        
        
        NSLayoutConstraint.activate([
            crossButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            crossButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            crossButton.widthAnchor.constraint(equalToConstant: 30),
            crossButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.blackView.alpha = 0.8
            self.imageView.layer.cornerRadius = 0
            self.topImage.constant = 100
            self.leadingImage.constant = 0
            self.widthImage.constant = UIScreen.main.bounds.width
            self.heightImage.constant = UIScreen.main.bounds.width
            self.layoutIfNeeded()
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.crossButton.alpha = 1
            }
        }
    }
    
    @objc private func cancelAction() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.crossButton.alpha = 0
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.imageView.layer.cornerRadius = 50
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







