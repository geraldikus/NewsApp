//
//  RegistrationViewController.swift
//  NewsApp
//
//  Created by Anton on 26.06.23.
//

import UIKit
import FirebaseAuth

protocol RegistrationDelegate: AnyObject {
    func didCompleteRegistration()
}

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
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
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.heightAnchor.constraint(equalToConstant: 250)
            
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            delegate?.didCompleteRegistration()
            completion?()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailTextField.becomeFirstResponder()
        }
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
        emailTextField.autocapitalizationType = .none
        emailTextField.leftViewMode = .always
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
    }
    
    func passwordTextFieldConfigure() {
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
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
    
    
    //MARK: Actions and Firebase
    
    func addAlertControllerWithOkButton(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
    
    @objc func logInButtonTapped() {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            
            addAlertControllerWithOkButton(title: "Invalid information in the email and password input fields.", message: "")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] results, error in
            guard let strongSelf = self else { return }
            guard error == nil else {
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            strongSelf.delegate?.didCompleteRegistration()
            strongSelf.completion?()
        }
    }
    
    @objc func registrationButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            
            addAlertControllerWithOkButton(title: "Invalid information in the email and password input fields", message: "")
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            guard let strongSelf = self else { return }
            guard error == nil else {
                if let errorCode = AuthErrorCode.Code(rawValue: error!._code) {
                    if errorCode == .emailAlreadyInUse {
                        strongSelf.addAlertControllerWithOkButton(title: "Such an account already exists.", message: "Try pressing Log In button.")
                    } else {
                        self?.addAlertControllerWithOkButton(title: "Something went wrong.", message: "Please check the correctness of the form entries and try again.")
                    }
                }
                return
            }
            
            print("You signIn")
            
            strongSelf.delegate?.didCompleteRegistration()
            strongSelf.completion?()
        }
        
    }
    
    func showCreateAccount(email: String, password: String) {
        let alertController = UIAlertController(title: "Create account", message: "Would you like to create an account?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Continue", style: .default,
                                                handler: { _ in
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                
                guard let strongSelf = self else { return }
                
                guard error == nil else {
                    self?.addAlertControllerWithOkButton(title: "Something went wrong.", message: "Please check the correctness of the form entries and try again.")
                    
                    print("Account creation failed")
                    return
                }
                
                print("You signIn")
                
                strongSelf.delegate?.didCompleteRegistration()
                strongSelf.completion?()
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    //MARK: Keyboard

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            logInButtonTapped()
        }
        
        return true
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
        DispatchQueue.main.async {
            if self.traitCollection.userInterfaceStyle == .dark {
                self.emailTextField.layer.borderColor = UIColor.white.cgColor
                self.passwordTextField.layer.borderColor = UIColor.white.cgColor
            } else {
                self.emailTextField.layer.borderColor = UIColor.black.cgColor
                self.passwordTextField.layer.borderColor = UIColor.black.cgColor
            }
        }
    }

}
