//
//  RegistrationViewController.swift
//  NewsApp
//
//  Created by Anton on 26.06.23.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    let label = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    let registrationButton = UIButton()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        labelConfigure()
        emailTextFieldConfigure()
        passwordTextFieldConfigure()
        
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        addElementsInStackView()
        setupStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
    
    func addElementsInStackView() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(registrationButton)

    }
    
    func labelConfigure() {
        label.text = "Registration form"
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
    }
    
    func emailTextFieldConfigure() {
        emailTextField.placeholder = "Email"
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.cornerRadius = 5
        emailTextField.borderStyle = .roundedRect
    }
    
    func passwordTextFieldConfigure() {
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.borderStyle = .roundedRect
//
//        if traitCollection.userInterfaceStyle == .dark {
//            passwordTextField.layer.borderColor = UIColor.white.cgColor
//            passwordTextField.layer.borderWidth = 0.5
//            passwordTextField.layer.cornerRadius = 5
//        } else {
//            passwordTextField.layer.borderColor = UIColor.black.cgColor
//            passwordTextField.layer.borderWidth = 0.5
//            passwordTextField.layer.cornerRadius = 5
//        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                updatePasswordTextFieldBorderColor()
            }
        } else {
            // Fallback on earlier versions
            if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
                updatePasswordTextFieldBorderColor()
            }
        }
    }

    func updatePasswordTextFieldBorderColor() {
        if traitCollection.userInterfaceStyle == .dark {
            passwordTextField.layer.borderColor = UIColor.white.cgColor
        } else {
            passwordTextField.layer.borderColor = UIColor.black.cgColor
        }
    }

    
    
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10 // Опционально, для добавления промежутков между элементами
    }

}
