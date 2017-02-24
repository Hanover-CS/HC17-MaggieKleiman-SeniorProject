//
//  ThirdViewController.swift
//  TMWH2
//
//  Created by Margaret Kleiman on 11/13/16.
//  Copyright © 2016 Margaret Kleiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ThirdViewController: UIViewController {
    
    
    // Declare the text fields for each day
    // Declare the merchant name label
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var merchantName: UILabel!
    
    @IBOutlet weak var monday: UITextView!
    @IBOutlet weak var tuesday: UITextView!
    @IBOutlet weak var wednesday: UITextView!
    @IBOutlet weak var thursday: UITextView!
    @IBOutlet weak var friday: UITextView!
    
    //Load the firebase data connection to this view controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if (FIRAuth.auth()?.currentUser == nil) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "firebaseLoginViewController")
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
    }
    
    // Declare the update button
    // Updates the inforation in the firebase database
    // Brings user main to main screen upon clicking update
    @IBAction func updateClicked(_ sender: Any) {
        let name = FIRAuth.auth()?.currentUser?.uid
        let dbref = FIRDatabase.database().reference()
        let ref = dbref.child("stores").child(name!).child("days").child("monday")
        let mondayValue = monday.text as? NSString
        ref.setValue(mondayValue)
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "tabBarController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // Populate label with name of merchant logged in
    func populateName() {
        let name = FIRAuth.auth()?.currentUser?.uid
        merchantName.text = name
        let dbref = FIRDatabase.database().reference()
        let ref = dbref.child("stores").child(name!)
        ref.observeSingleEvent(of: .value, with:
            { (snapshot : FIRDataSnapshot) in
                let snapshotValue = snapshot.value as? NSDictionary
                self.merchantName.text = snapshotValue?["name"] as? String
        })
    }
    
    // Declare the logout button
    // Logs the current user out of the application
    // Calls onLogoutClicked() to take user back to home screen
    @IBAction func logoutClicked(_ sender: Any) {
        //logout
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print("error signing out")
        }
        
        //Revert back to home screen on logout
        self.onLogoutClicked()
        
    }
    
    // Instantiate View
    override func viewDidAppear(_ animated: Bool) {
        populateName()
    }
    
    // Instantiates the main view controller
    func onLogoutClicked() {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "tabBarController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Recognizes tap to bring up the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ThirdViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    // function to dismiss the keyboard
    // with tap on screen after done entering text
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
