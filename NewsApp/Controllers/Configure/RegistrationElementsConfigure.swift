//
//  RegistrationElementsConfigure.swift
//  NewsApp
//
//  Created by Anton on 28.06.23.
//

import UIKit

func labelConfigure(label: UILabel) {
    label.text = "Registration form"
    label.font = UIFont(name: "Helvetica-Bold", size: 24)
    label.textAlignment = .center
}

func emailTextFieldConfigure(emailTextField: UITextField) {
    emailTextField.placeholder = "Email"
    emailTextField.layer.borderWidth = 0.5
    emailTextField.layer.cornerRadius = 5
    emailTextField.borderStyle = .roundedRect
    emailTextField.autocapitalizationType = .none
    emailTextField.leftViewMode = .always
    emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
}

func passwordTextFieldConfigure(passwordTextField: UITextField) {
    passwordTextField.placeholder = "Password"
    passwordTextField.layer.borderWidth = 0.5
    passwordTextField.layer.cornerRadius = 5
    passwordTextField.borderStyle = .roundedRect
    passwordTextField.isSecureTextEntry = true
    passwordTextField.autocapitalizationType = .none
    passwordTextField.leftViewMode = .always
    passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
}

func logInButtonConfiguration(logInButton: UIButton) {
    logInButton.setTitle("Log In", for: .normal)
    logInButton.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
    logInButton.layer.cornerRadius = 5
}

func registrationButtonConfiguration(registrationButton: UIButton) {
    registrationButton.setTitle("Sign In", for: .normal)
    registrationButton.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
    registrationButton.layer.cornerRadius = 5
}
