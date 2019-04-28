//
//  Add2ViewController.swift
//  WaterClosetV3
//
//  Created by Michael Mcmanus on 4/28/19.
//  Copyright © 2019 Michael Mcmanus. All rights reserved.
//

import UIKit

class Add2ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addBathroomBtn: ShadowButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onaddBtnPress(_ sender: Any) {
        let str = nameTextField.text
        let emptyEmailAlert = UIAlertController(title: "Success", message: "The bathroom at \(str ?? "your location") has been successfully added to our database.", preferredStyle: .alert)
        emptyEmailAlert.addAction(UIAlertAction(title: "Cool!", style: .cancel, handler: nil))
        self.present(emptyEmailAlert, animated: true)
        self.performSegue(withIdentifier: "homeSegue", sender: self)
        
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
