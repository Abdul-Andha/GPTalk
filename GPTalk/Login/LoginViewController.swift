//
//  ViewController.swift
//  GPTalk
//
//  Created by Abdul Andha on 4/13/23.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    private let signInWithGoogleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "googleIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
      }()

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the sign-in with Google button to the view
        signInWithGoogleButton.addTarget(self, action: #selector(handleSignInWithGoogle), for: .touchUpInside)
        view.addSubview(signInWithGoogleButton)

        // Set the frame for the button
        signInWithGoogleButton.frame = CGRect(x: 100, y: 450, width: 190, height: 50)
        
        
    }

    @IBAction func onLoginTapped(_ sender: Any) {
        guard let username = usernameField.text,
              let password = passwordField.text,
              !username.isEmpty,
              !password.isEmpty else {

            showMissingFieldsAlert()
            return
        }
        
        User.login(username: username, password: password) { [weak self] result in

            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user)")

                // Post a notification that the user has successfully logged in.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil, userInfo: ["username": username])

            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
        
        
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Log in", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to log you in.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    private func showMessage(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

}

// MARK: - Sign in with Google section
extension LoginViewController {
    @objc fileprivate func handleSignInWithGoogle() {
        GIDSignIn.sharedInstance.signOut() // This should be called when the user logs out from your app. For login testing purposes, we are calling it each time the user taps on the 'signInWithGoogleButton' button.
        
        let signInConfig = GIDConfiguration(clientID: "817483787663-taqfv221dlfcm9d8470a4s44iir4nktn.apps.googleusercontent.com") // See https://developers.google.com/identity/sign-in/ios/sign-in for more details
        
        // Method provided by the GoogleSignIn framework. See https://developers.google.com/identity/sign-in/ios/sign-in for more details
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self.navigationController) { [weak self] googleUser, error in
            if let error = error {
                self?.showMessage(title: "Error", message: error.localizedDescription)
                return
            }
            
            // After Google returns a successful sign in, we get the users id and idToken
            guard let googleUser = googleUser,
                  let userId = googleUser.userID,
                  let idToken = googleUser.authentication.idToken
            else { fatalError("This should never happen!?") }
            
            // With the user information returned by Google, you need to sign in the user on your Back4App application
            User.google.login(id: userId, idToken: idToken) { result in
                // Returns the User object asociated to the GIDGoogleUser object returned by Google
                switch result {
                case .success(let user):
                    // After the login succeeded, we send the user to the home screen
                    // Additionally, you can complete the user information with the data provided by Google
                    let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! HomeViewController
                    homeController.user = user
                    
                    self?.navigationController?.pushViewController(homeController, animated: true)
                case .failure(let error):
                    // Handle the error if the login process failed
                    self?.showMessage(title: "Failed to sign in", message: error.message)
                }
            }
        }
    }
}

