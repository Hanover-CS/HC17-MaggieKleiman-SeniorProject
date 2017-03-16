//
//  RedPepperoniViewController.swift
//  TMWH2
//
//  Created by Margaret Kleiman on 3/14/17.
//  Copyright © 2017 Margaret Kleiman. All rights reserved.
//

import UIKit

class RedPepperoniViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBack(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "specialsScreen"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}


