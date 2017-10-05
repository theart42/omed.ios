//
//  IOViewController.swift
//  Omed
//
//  Created by Frank on 05/10/2017.
//  Copyright © 2017 Warpnet. All rights reserved.
//

import UIKit

class IOViewController: UIViewController {
    @IBOutlet weak var TextViewOutput: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        TextViewOutput.text = OmedSimpleIO.read()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
