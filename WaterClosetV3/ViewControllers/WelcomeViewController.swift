//
//  WelcomeViewController.swift
//  WaterClosetV3
//
//  Created by Michael Mcmanus on 4/28/19.
//  Copyright © 2019 Michael Mcmanus. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {


    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - User Login
    func logUserIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to sign user in with error: ", error.localizedDescription)
                // If user input invalid password
                if error.localizedDescription == "The password is invalid or the user does not have a password." {
                    let invalidPasswordAlert = UIAlertController(title: "Invalid password", message: "The password you entered is invalid. Please try again.", preferredStyle: .alert)
                    invalidPasswordAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(invalidPasswordAlert, animated: true)
                } // If user input invalid username
                else if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    let invalidUsernameAlert = UIAlertController(title: "Invalid email", message: "The email address you entered is invalid. Please try again.", preferredStyle: .alert)
                    invalidUsernameAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(invalidUsernameAlert, animated: true)
                }
                return
            }
            print("Successfully logged user in...")
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    // MARK: - Helper Functions & Actions
    
    @objc func handleLogin() {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        if email == "" {
            print("The email field is empty. Please input an email address and try to sign up again!")
            let emptyEmailAlert = UIAlertController(title: "Empty email field", message: "The email field is empty. Please input an email address and try to sign up again.", preferredStyle: .alert)
            emptyEmailAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(emptyEmailAlert, animated: true)
        } else if password == "" {
            print("The password field is empty. Please input a password and try to sign up again!")
            let emptyPasswordAlert = UIAlertController(title: "Empty password field", message: "The first password field is empty. Please input a password and try to sign up again.", preferredStyle: .alert)
            emptyPasswordAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(emptyPasswordAlert, animated: true)
        } else {
            logUserIn(withEmail: email, password: password)
        }
    }
    
    @IBAction func onloginButtonPress(_ sender: Any) {
        handleLogin()
    }
    
    @IBAction func onsignupButtonPress(_ sender: Any) {
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
