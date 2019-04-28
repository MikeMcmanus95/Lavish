//
//  SignUp2ViewController.swift
//  WaterClosetV3
//
//  Created by Michael Mcmanus on 4/28/19.
//  Copyright © 2019 Michael Mcmanus. All rights reserved.
//

import UIKit

class SignUp2ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpassTextField: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onDoneBtnPress(_ sender: Any) {
//        if error = nil {
              print("Sign Up Completed.")
//        } else {
//            print(Error)
//        }
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
