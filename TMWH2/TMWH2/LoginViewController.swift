//
//  LoginViewController.swift
//  TMWH2
//
//  Created by Margaret Kleiman on 11/13/16.
//  Copyright © 2016 Margaret Kleiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    

    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // recognizer to bring up keyboard with finger tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ************************************************
    // function to log in specific user upon successful
    // email and password combination
    // shows error alert message if incorrect login
    // ************************************************
    @IBAction func loginClicked(_ sender: AnyObject) {
        
        if (!CheckInput()) {
            return 
        }
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (user, error) in
            if let error = error {
                Utilities().ShowAlert(title: "Error", message: error.localizedDescription, vc: self)
                print(error.localizedDescription)
                return
            }
            print("signed in!")
            self.onClickLogin()
        })
    }
    
    // ***********************************************
    // upon successful login, this function brings the
    // user back to the homepage
    // ***********************************************
    func onClickLogin() {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "tabBarController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    // ******************************************************
    // Function to check the password and username validity
    // If the email or password is invalid, the corresponding
    // text field will turn red to alert the user of their 
    // invalid information
    // ******************************************************
    func CheckInput () -> Bool {
        if ((emailTextField.text?.characters.count)! < 5)
        {
            emailTextField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        } else {
            emailTextField.backgroundColor = UIColor.white
        }
        if ((passwordTextField.text?.characters.count)! < 5)
        {
            passwordTextField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        } else {
            passwordTextField.backgroundColor = UIColor.white
        }
        return true

    }
    

    @IBAction func onBackClick(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "tabBarController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
