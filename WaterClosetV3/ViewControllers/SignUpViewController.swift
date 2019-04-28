//
//  SignUpViewController.swift
//  WaterClosetV3
//
//  Created by Michael Mcmanus on 4/28/19.
//  Copyright © 2019 Michael Mcmanus. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var genderPicker: UISegmentedControl!
    @IBOutlet weak var parentPicker: UISegmentedControl!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    private var datePicker: UIDatePicker?
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel1.alpha = 0
        textLabel2.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.textLabel1.alpha = 1
            self.textLabel2.alpha = 1
        })
        
        // Configures the Date Picker to have a 'done' button
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(SignUpViewController.dateChanged(datePicker:)), for: .valueChanged)
        dobTextField.inputView = datePicker
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(SignUpViewController.dismissPicker))
        dobTextField.inputAccessoryView = toolBar

        // Do any additional setup after loading the view.
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
        
    }

    
    // Formats the date properly
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dobTextField.text = dateFormatter.string(from: datePicker.date)
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
