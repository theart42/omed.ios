//
//  JBdetectViewController.swift
//  Omed
//
//  Created by Frank on 06/10/2017.
//  Copyright © 2017 Warpnet. All rights reserved.
//

import UIKit

class JBdetectViewController: UIViewController {

    @IBOutlet weak var TextViewOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (OmedSimpleJBdetect.detect()) {
            TextViewOutput.text = "Jailbroken!"
        }
        else {
            TextViewOutput.text = "No worries"
        }
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
