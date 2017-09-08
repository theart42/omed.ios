//
//  ViewController.swift
//  Omed
//
//  Created by Frank on 06/09/2017.
//  Copyright © 2017 Warpnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TextViewOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        OmedSimpleKeychain.write()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func readFile()
    {
        let output = OmedSimpleIO.read()
        self.TextViewOutput.text = output
    }

    @IBAction func readHTTPS()  
    {
        OmedSimpleHTTPS.request() { (output) in
            DispatchQueue.main.async {
                self.TextViewOutput.text = output
            }
        }
    }
    
    @IBAction func readHTTPSPinned()
    {
        OmedSimpleHTTPS.requestPinned() { (output) in
            DispatchQueue.main.async {
                self.TextViewOutput.text = output
            }
        }
    }
    
    @IBAction func readKey()
    {
        let output = OmedSimpleKeychain.read()
        self.TextViewOutput.text = output
    }
    
    @IBAction func crypt()
    {
        let output = OmedSimpleCrypto.read()
        self.TextViewOutput.text = output
    }
    
}

