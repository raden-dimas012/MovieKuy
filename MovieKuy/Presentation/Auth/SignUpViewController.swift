//
//  SignUpViewController.swift
//  MovieKuy
//
//  Created by Raden Dimas on 21/05/22.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private lazy var loginImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo-app")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Email"
        textField.addTarget(self, action: #selector(handleEmailTextChange), for: .editingChanged)
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Username"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(handlePasswordTextChange), for: .editingChanged)
        textField.layer.cornerRadius = 5
        
        return textField
    }()
        
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleTextField), for: .touchUpInside)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))

        view.addSubviews(
            loginImage,
            emailTextField,
            usernameTextField,
            passwordTextField,
            registerButton
        )
        setupConstraints()
    }
    
    
    @objc func handleTextField() {
        guard let emailText = emailTextField.text?.trimmingCharacters(in: .whitespaces),
              let usernameText = usernameTextField.text?.trimmingCharacters(in: .whitespaces),
              let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        else { return }
        
        switch(emailText.isEmpty,usernameText.isEmpty,passwordText.isEmpty) {
            
        case (true,true,true):
            setupAlert(title: "Error", message: "Please Input Email, Username & Password", style: .alert)
        case (false,true,true):
            setupAlert(title: "Error", message: "Please Input Username & Password", style: .alert)
        case (false,false,true):
            setupAlert(title: "Error", message: "Please Input Password", style: .alert)
        case (true,true,false):
            setupAlert(title: "Error", message: "Please Input Email & Username", style: .alert)
        case (true,false,true):
            setupAlert(title: "Error", message: "Please Input Email & Password", style: .alert)
        case (true,false,false):
            setupAlert(title: "Error", message: "Please Input Email", style: .alert)
        case (false,true,false):
            setupAlert(title: "Error", message: "Please Input Username", style: .alert)
            
        default:
            if emailText.isValidEmail && passwordText.isValidPassword(passwordText) {
                setupAlert(title: "Success", message: "Success Registered Please Sign In!", style: .alert)
                AuthManager.shared.signUp(
                    email: emailText,
                    username: usernameText,
                    password: passwordText) { [weak self] result in
                        switch result {
                        case .success():
                            self?.dismiss(animated: true)
                        case .failure(_):
                            self?.setupAlert(title: "Failed", message: "Something went wrong!", style: .alert)
                        }
                    }
            } else {
                setupAlert(title: "Failed", message: "Email or Password is invalid", style: .alert)
            }
        }
        
    }
    
    @objc func handleEmailTextChange() {
        guard let text = emailTextField.text else {
            return
        }
        if text.isValidEmail {
            emailTextField.layer.borderColor = UIColor.systemGreen.cgColor
        } else if text.isEmpty {
            emailTextField.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            emailTextField.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    @objc func handlePasswordTextChange() {
        guard let text = passwordTextField.text else {
            return
        }
        if text.isValidPassword(text) {
            passwordTextField.layer.borderColor = UIColor.systemGreen.cgColor
        } else if text.isEmpty{
            passwordTextField.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginImage.widthAnchor.constraint(equalToConstant: 220),
            loginImage.heightAnchor.constraint(equalToConstant: 150),
            
            emailTextField.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 30),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            usernameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            registerButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setupAlert(
        title titleAlert: String,
        message messageAlert: String,
        style styleAlert: UIAlertController.Style)
    {
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: styleAlert)
        alert.addAction(UIAlertAction(title: "OKE", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
