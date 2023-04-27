//
//  ForgotPasswordViewController.swift
//  GPTalk
//
//  Created by Tameem Ahmed on 4/14/23.
//

import UIKit
import ParseSwift



class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSendTapped(_ sender: Any) {
            guard let email = emailField.text,
                  !email.isEmpty else {
                showMissingFieldsAlert()
                return
        }
        
        User.passwordReset(email: email) { [weak self] result in

            switch result {
            case .success:
                print("✅ Successfully sent email to \(email)")

                NotificationCenter.default.post(name: Notification.Name("sent"), object: nil)

            case .failure(let error):
                // Failed sign up
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




}
