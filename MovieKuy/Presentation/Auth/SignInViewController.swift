//
//  LoginViewController.swift
//  MovieKuy
//
//  Created by Raden Dimas on 21/05/22.
//

import UIKit
import FirebaseAuth

final class SignInViewController: UIViewController {
    
    private lazy var loginImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo-app")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleTextField), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
    }
    
    @objc func goToRegisterView() {
        let viewController = UINavigationController(rootViewController: SignUpViewController())
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    @objc func handleTextField() {
        guard let usernameText = usernameTextField.text?.trimmingCharacters(in: .whitespaces),
              let passwordText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        else { return }
    
        switch(usernameText.isEmpty,passwordText.isEmpty) {
        case (true,true):
            setupAlert(title: "Error", message: "Please Input Username & Password!", style: .alert)

        case (true, false) :
            setupAlert(title: "Error", message: "Please Input Username!", style: .alert)

        case (false, true) :
            setupAlert(title: "Error", message: "Please Input Password!", style: .alert)

        default:
            if passwordText.isValidPassword(passwordText) {
                setupAlert(title: "Success", message: "Success Sign In", style: .alert)
                AuthManager.shared.signIn(username: usernameText, password: passwordText) { [weak self] result in
                    switch result {
                    case .success():
                        self?.dismiss(animated: true, completion: nil)
                    case .failure(_):
                        self?.setupAlert(title: "Failed", message: "Something went wrong!", style: .alert)
                    }
                }
            } else {
                setupAlert(title: "Error", message: "Password is not valid", style: .alert)
            }
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
    func setupViews() {
        view.addSubviews(
            loginImage,
            usernameTextField,
            passwordTextField,
            loginButton,
            separatorView,
            registerButton
        )
        separatorView.addSubviews(
            lineSeparatorView,
            orLabel
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            loginImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginImage.widthAnchor.constraint(equalToConstant: 220),
            loginImage.heightAnchor.constraint(equalToConstant: 150),
            
            usernameTextField.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 30),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            loginButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            separatorView.heightAnchor.constraint(equalToConstant: 30),
            separatorView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            
            orLabel.centerXAnchor.constraint(equalTo: separatorView.centerXAnchor),
            orLabel.centerYAnchor.constraint(equalTo: separatorView.centerYAnchor),
            orLabel.widthAnchor.constraint(equalToConstant: 90),
            orLabel.heightAnchor.constraint(equalToConstant: 20),
  
            lineSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            lineSeparatorView.widthAnchor.constraint(equalTo: separatorView.widthAnchor),
            lineSeparatorView.centerXAnchor.constraint(equalTo: separatorView.centerXAnchor),
            lineSeparatorView.centerYAnchor.constraint(equalTo: separatorView.centerYAnchor),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: lineSeparatorView.bottomAnchor, constant: 35),
            registerButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 45),
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
