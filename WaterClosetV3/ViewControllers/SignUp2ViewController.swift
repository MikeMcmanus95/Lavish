//
//  SignUp2ViewController.swift
//  WaterClosetV3
//
//  Created by Michael Mcmanus on 4/28/19.
//  Copyright © 2019 Michael Mcmanus. All rights reserved.
//

import UIKit
import Firebase

class SignUp2ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpassTextField: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func createUser(withEmail email: String, password: String, username: String) {
        // Attempt to create user if username is unique
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // General sign up error
            if let error = error {
                print("Failed to sign user up with error: ", error.localizedDescription)
                let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(errorAlert, animated: true)
                return
            }
            
            // Get the unique userID of the current user signing up
            guard let userID = result?.user.uid else { return }
            
            let userInfo = ["username": username, "email": email]
            
            // Update the database for the userID above with the email address & username entered
            Database.database().reference().child("user").child(userID).updateChildValues(userInfo, withCompletionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to updated database with error: ", error.localizedDescription)
                    return
                }
                print("Successfully signed user up...")
                self.performSegue(withIdentifier: "signupSegue", sender: self)
            })
            
        }
    }
    
    @objc func handleSignUp(){
        guard let username = usernameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        guard let confirmPass = confirmpassTextField.text else { return }
        
        if email == "" {
            print("The email field is empty. Please input an email address and try to sign up again!")
            let emptyEmailAlert = UIAlertController(title: "Empty email field", message: "The email field is empty. Please input an email address and try to sign up again.", preferredStyle: .alert)
            emptyEmailAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(emptyEmailAlert, animated: true)
            return
        } else if username == "" {
            print("The username field is empty. Please input a username and try to sign up again!")
            let emptyUsernameAlert = UIAlertController(title: "Empty username field", message: "The username field is empty. Please input a username and try to sign up again.", preferredStyle: .alert)
            emptyUsernameAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(emptyUsernameAlert, animated: true)
            return
        } else if pass == "" {
            print("The first password field is empty. Please input a password and try to sign up again!")
            let emptyPasswordAlert = UIAlertController(title: "Empty password field", message: "The first password field is empty. Please input a password and try to sign up again.", preferredStyle: .alert)
            emptyPasswordAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(emptyPasswordAlert, animated: true)
            return
        } else if confirmPass == "" {
            print("The second password field is empty. Please input a confirmation password and try to sign up again!")
            let emptyConfirmPasswordAlert = UIAlertController(title: "Empty confirmation password field", message: "The second password field is empty. Please input a confirmation password and try to sign up again.", preferredStyle: .alert)
            emptyConfirmPasswordAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(emptyConfirmPasswordAlert, animated: true)
            return
        } else if pass != confirmPass {
            print("Please make sure both passwords match!")
            let passwordMismatchAlert = UIAlertController(title: "Password field mismatch", message: "The passwords entered do not match. Make sure they match and then try to sign up again.", preferredStyle: .alert)
            passwordMismatchAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(passwordMismatchAlert, animated: true)
            return
        }
        
        
        // Make sure the username user entered is unique
        Database.database().reference().child("user").queryOrdered(byChild: "username").queryEqual(toValue: username).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value!) // Snapshot of keys/values in DB that have matching username
            // If username is not unique, alert user and cancel sign up process
            if (!(snapshot.value! is NSNull)) {
                print("Username already exists!")
                let usernameExistsAlert = UIAlertController(title: "Username exists", message: "The username entered already exists. Please input another username and try to sign up again.", preferredStyle: .alert)
                usernameExistsAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(usernameExistsAlert, animated: true)
                return
            }
        })
        
        createUser(withEmail: email, password: pass, username: username)
        
    }
    
    @IBAction func onDoneBtnPress(_ sender: Any) {
              handleSignUp()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
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
