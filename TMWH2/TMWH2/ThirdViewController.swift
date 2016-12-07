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
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var merchantName: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if (FIRAuth.auth()?.currentUser == nil) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "firebaseLoginViewController")
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
    }
    
    // populate label with name of merchant logged in 
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
    
    override func viewDidAppear(_ animated: Bool) {
        populateName()
    }
    
    func onLogoutClicked() {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "tabBarController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
