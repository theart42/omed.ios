//
//  KeystoreViewController.swift
//  Omed
//
//  Created by Frank on 05/10/2017.
//  Copyright © 2017 Warpnet. All rights reserved.
//

import UIKit

class KeystoreViewController: UIViewController {

    @IBOutlet weak var PasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //For the purpose of being able to hide the keyboard later.
        PasswordField.delegate = self as? UITextFieldDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        PasswordField.text = OmedSimpleKeychain.read()
    }

    @IBAction func submitPassword(_ sender: Any) {
        OmedSimpleKeychain.writeValue(password:PasswordField.text!)
        
        //Hide the keyboard down after hitting submit
        PasswordField.resignFirstResponder()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
