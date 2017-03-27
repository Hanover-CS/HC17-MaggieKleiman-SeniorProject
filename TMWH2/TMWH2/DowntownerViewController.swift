//
//  DowntownerViewController.swift
//  TMWH2
//
//  Created by Margaret Kleiman on 3/14/17.
//  Copyright © 2017 Margaret Kleiman. All rights reserved.
//

import UIKit

class DowntownerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ****************************************************
    // function to bring the user back to the homepage upon
    // click of the back button
    // ****************************************************
    @IBAction func onClickBack(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "tabBarController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    // ******************************
    // Function to initate phone call
    // ******************************
    @IBAction func makeCall(_ sender: UIButton) {
        let url = NSURL(string: "tel://8122654343")!
        UIApplication.shared.openURL(url as URL)
    }
    
    // ****************************************
    // function to bring up restaurants webpage
    // ****************************************
    @IBAction func instantiateWebsite(_ sender: UIButton) {
        if let url = URL(string: "https://www.facebook.com/thedowntownermadison/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}


