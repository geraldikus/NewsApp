//
//  RegistrationViewController.swift
//  NewsApp
//
//  Created by Anton on 26.06.23.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func didCompleteRegistration()
}

class RegistrationViewController: UIViewController {
    
    weak var delegate: RegistrationDelegate?
    
    var completion: (() -> Void)?
    
    let mainViewController = MainViewController()
    let label = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let logInButton = UIButton()
    let registrationButton = UIButton()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelConfigure()
        emailTextFieldConfigure()
        passwordTextFieldConfigure()
        logInButtonConfiguration()
        registrationButtonConfiguration()
        
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        addElementsInStackView()
        setupStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.heightAnchor.constraint(equalToConstant: 250)
            
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
    }
    
    func addElementsInStackView() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(logInButton)
        stackView.addArrangedSubview(registrationButton)

    }
    
    //MARK: Elements
    
    func labelConfigure() {
        label.text = "Registration form"
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.textAlignment = .center
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

    }
    
    func logInButtonConfiguration() {
        logInButton.setTitle("Log In", for: .normal)
        logInButton.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        logInButton.layer.cornerRadius = 5
    }
    
    func registrationButtonConfiguration() {
        registrationButton.setTitle("Sign In", for: .normal)
        registrationButton.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        registrationButton.layer.cornerRadius = 5
    }
    
    
    //MARK: Actions
    
    @objc func logInButtonTapped() {
        delegate?.didCompleteRegistration()
        completion?()
    }
    
    //MARK: Keyboard
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.frame.origin.y = self.view.frame.height - keyboardSize.height - self.stackView.frame.height - 20
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        // Возврат констрейнтов stackView на исходное место
        UIView.animate(withDuration: 0.3) {
            self.stackView.center = self.view.center
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    //MARK: Dark theme
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 12.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                updateTextFieldBorderColor()
            }
        } else {
           
            if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
                updateTextFieldBorderColor()
            }
        }
    }

    func updateTextFieldBorderColor() {
        if traitCollection.userInterfaceStyle == .dark {
            emailTextField.layer.borderColor = UIColor.white.cgColor
            passwordTextField.layer.borderColor = UIColor.white.cgColor
        } else {
            emailTextField.layer.borderColor = UIColor.black.cgColor
            passwordTextField.layer.borderColor = UIColor.black.cgColor
        }
    }
}
