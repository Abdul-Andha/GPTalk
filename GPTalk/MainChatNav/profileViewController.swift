//
//  profileViewController.swift
//  GPTalk
//
//  Created by Tameem Ahmed on 4/27/23.
//

import UIKit
import StreamChat
import StreamChatUI

class ProfileViewController: UIViewController {
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont(name: "Inter-Regular_ExtraBold", size: 37.0)
        usernameLabel.textColor = .label
        return usernameLabel
    }()
    
    private let passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.font = UIFont(name: "Inter-Regular_ExtraBold", size: 80)
        passwordLabel.textColor = .label
        passwordLabel.text = "Change Password:"
        return passwordLabel
    }()
    
    private let signoutButton: UIButton = {
        let signoutButton = UIButton()
        signoutButton.translatesAutoresizingMaskIntoConstraints = false
        signoutButton.setTitleColor(.red, for: .normal)
        signoutButton.setTitle("Sign Out", for: .normal)
        signoutButton.backgroundColor = .systemBlue
        signoutButton.setTitleColor(.white, for: .normal)
        signoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signoutButton.layer.cornerRadius = 10
        
        return signoutButton
    }()
    
    private let sendButton: UIButton = {
        let sendButton = UIButton()
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitleColor(.red, for: .normal)
        sendButton.setTitle("Send Email", for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        sendButton.layer.cornerRadius = 10
        
        return sendButton
    }()
    
    private let passwordTextField: UITextField = {
       let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Email"
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.cornerRadius = 5

        return passwordTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(usernameLabel)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(sendButton)
        view.addSubview(signoutButton)
        
        usernameLabel.text = ChatClient.shared.currentUserId
        signoutButton.addTarget(self, action: #selector(onLogOutTapped), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(onSendTapped), for: .touchUpInside)
        
        addConstraints()
    }
    
    @objc func onLogOutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }

    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 80),
            usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: 30),
            passwordLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 0),
            
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 200),
            sendButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            
            signoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signoutButton.heightAnchor.constraint(equalToConstant: 50),
            signoutButton.widthAnchor.constraint(equalToConstant: 200),
            signoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        
        ])
    }
    
    @objc func onSendTapped(_ sender: Any) {
            guard let email = passwordTextField.text,
                  !email.isEmpty else {
                showMissingFieldsAlert()
                return
        }
        
        User.passwordReset(email: email) { [weak self] result in
            
            switch result {
            case .success:
                print("✅ Successfully sent email to \(email)")

                self?.showConfirmation(description: "If you can't find your email, please check your email and try again")

            case .failure(let error):
                
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func showMissingFieldsAlert() {
            let alertController = UIAlertController(title: "Oops...", message: "We need all fields filled out.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            present(alertController, animated: true)
        }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Send", message: description ?? "Please check your email and try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func showConfirmation(description: String?) {
        let alertController = UIAlertController(title: "Your Email was sent!", message: description ?? "If you don't recieve an email, please check your spelling", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

