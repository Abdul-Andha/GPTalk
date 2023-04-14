//
//  SignUpViewController.swift
//  GPTalk
//
//  Created by Tameem Ahmed on 4/14/23.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func onSignUpTapped(_ sender: Any) {
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              !username.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty else {
            showMissingFieldsAlert()
            return
    }
        var newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password
        newUser.firstName = firstName
        newUser.lastName = lastName
        

        newUser.signup { [weak self] result in

            switch result {
            case .success(let user):

                print("✅ Successfully signed up user \(user)")

                // Post a notification that the user has successfully signed up.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)

            case .failure(let error):
                // Failed sign up
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    
    private func showMissingFieldsAlert() {
            let alertController = UIAlertController(title: "Oops...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            present(alertController, animated: true)
        }
    

}
