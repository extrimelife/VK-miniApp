//
//  LogInViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let notificationCenter = NotificationCenter.default
    
    private let login = "extrimelife@hotmail.ru"
    private let password = "12345678"
    
    private let imageView: UIImageView = {
        let viewImage = UIImageView()
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        viewImage.image = .init(named: "logo")
        return viewImage
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    private let alertLabel: UILabel = {
        let labelAlert = UILabel()
        labelAlert.translatesAutoresizingMaskIntoConstraints = false
        labelAlert.text = "Password cannot be less than 8 characters"
        labelAlert.textColor = .red
        labelAlert.isHidden = true
        labelAlert.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return labelAlert
    }()
    
    private let logTextField: UITextField = {
        let textFieldLog = UITextField()
        textFieldLog.translatesAutoresizingMaskIntoConstraints = false
        textFieldLog.layer.borderColor = UIColor.lightGray.cgColor
        textFieldLog.layer.borderWidth = 0.5
        textFieldLog.placeholder = "Email of phone"
        textFieldLog.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textFieldLog.frame.height))
        textFieldLog.leftViewMode = .always
        textFieldLog.textColor = .black
        textFieldLog.font = .systemFont(ofSize: 16)
        textFieldLog.tintColor = .lightGray
        textFieldLog.clearButtonMode = .whileEditing
        return textFieldLog
    }()
    
    
    private let pasTextField: UITextField = {
        let textFieldPas = UITextField()
        textFieldPas.translatesAutoresizingMaskIntoConstraints = false
        textFieldPas.layer.borderColor = UIColor.lightGray.cgColor
        textFieldPas.layer.borderWidth = 0.5
        textFieldPas.placeholder = "Password"
        textFieldPas.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textFieldPas.frame.height))
        textFieldPas.leftViewMode = .always
        textFieldPas.textColor = .black
        textFieldPas.font = .systemFont(ofSize: 16)
        textFieldPas.tintColor = .lightGray
        textFieldPas.autocapitalizationType = .none
        textFieldPas.isSecureTextEntry = true
        textFieldPas.clearButtonMode = .whileEditing
        return textFieldPas
    }()
    
    private lazy var buttonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#4885CC")
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        button.backgroundImage(for: .application)
        button.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //Дополнительная view для scroll view(без него scroll работать не будет)
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupLayout()
        logTextField.delegate = self
        pasTextField.delegate = self
        hideKeyboardTappedAround()
    }
    
    
    
    // Функция для проверки валидации пароля
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    @objc private func goToProfile () {
        
        // Проверка на пустые поля логина и пароля с выделением текста и анимацией стека
        if logTextField.text == "" || pasTextField.text == "" {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: stackView.center.x - 10, y: stackView.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: stackView.center.x + 10, y: stackView.center.y))
            stackView.layer.add(animation, forKey: "position")
            logTextField.attributedPlaceholder = NSAttributedString(string: logTextField.placeholder ?? "",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            pasTextField.attributedPlaceholder = NSAttributedString(string: pasTextField.placeholder ?? "",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
        }  else {
            stackView.layer.removeAnimation(forKey: "position")
            
        }
        
        // Проверка на валидацию email
        if isValidEmail(logTextField.text!) == false && logTextField.text != ""  {
            logTextField.text = ""
            logTextField.attributedPlaceholder = NSAttributedString(string: "Email is incorrect",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
        }
        
        // Проверка на определенное количество вводимых символов пароля
        if pasTextField.text!.count < 8 && pasTextField.text != "" {
            alertLabel.text = alertLabel.text
            alertLabel.isHidden = false
            
        } else {
            alertLabel.isHidden = true
            
        }
        
        
        if logTextField.text == login && pasTextField.text == password {
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
            
        } else if logTextField.text != "" && pasTextField.text != ""  {
            let alert = UIAlertController(title: "Неверные данные", message: "Вы ввели неверный логин или пароль, попробуйте снова", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Попробовать еще раз", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        
        let offSet: CGFloat = 100
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let size = view.frame.height - keyboardSize.height
            scrollView.contentOffset = CGPoint(x: 0, y: buttonView.frame.origin.y - size + offSet)
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            
        }
    }
    
    @objc private func keyboardHide() {
        scrollView.contentOffset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        contentView.addSubview(buttonView)
        contentView.addSubview(alertLabel)
        [logTextField, pasTextField] .forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            
            // Констрейнт для картинки:
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            // Констрейнт для стэка:
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            // Констрейнт для проверки на длину пароля
            alertLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            alertLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            alertLabel.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            
            // Констрейнт для кнопки:
            buttonView.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            buttonView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Констрейнт для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Констрейнт для contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
        ])
        
    }
    
}


//Расширение для закрытия клавиатуры при нажатии на любую часть экрана
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func hideKeyboardTappedAround() {
        let press: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        press.cancelsTouchesInView = false
        view.addGestureRecognizer(press)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}







