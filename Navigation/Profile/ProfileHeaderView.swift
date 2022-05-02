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
        addSubview(image)
        addSubview(label)
        addSubview(text)
        addSubview(setupButton)
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let image: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "square"))
        imageView.layer.frame = CGRect(x: 16, y: 16, width: 100, height: 100)
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    let label: UILabel = {
        let textLabel = UILabel(frame: CGRect(x: 130, y: 0, width: 240, height: 80))
        textLabel.attributedText = NSMutableAttributedString(string: "Hipster Cat")
        textLabel.textColor = .black
        textLabel.backgroundColor = .clear
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return textLabel
    }()
    
    let text: UITextView = {
        let textView = UITextView(frame: CGRect(x: 130, y: 48, width: 240, height: 40))
        textView.text = "Waiting for something"
        textView.textColor = .gray
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    let setupButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 132, width: UIScreen.main.bounds.width - 32, height: 50))
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
    
    let textField: UITextField = {
        let fieldText = UITextField(frame: CGRect(x: 130, y: 80, width: 240, height: 40))
        fieldText.text = ""
        fieldText.backgroundColor = .white
        fieldText.layer.cornerRadius = 12
        fieldText.layer.borderWidth = 1
        fieldText.layer.borderColor = UIColor.black.cgColor
        fieldText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        fieldText.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return fieldText
    }()
    
    @objc private func tapAction() {
        text.text = statusText
        print(text.text ?? "")
    }
    
    @objc private func statusTextChanged() {
        statusText = textField.text ?? ""
        
        
    }
}
