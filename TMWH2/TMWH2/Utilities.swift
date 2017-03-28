//
//  Utilities.swift
//  TMWH2
//
//  Created by Margaret Kleiman on 11/14/16.
//  Copyright © 2016 Margaret Kleiman. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    // **********************************
    // function to display alert messages
    // **********************************
    func ShowAlert (title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
