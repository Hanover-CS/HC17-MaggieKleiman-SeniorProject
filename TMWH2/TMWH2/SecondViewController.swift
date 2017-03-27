//
//  SecondViewController.swift
//  TMWH2
//
//  Created by Margaret Kleiman on 11/13/16.
//  Copyright © 2016 Margaret Kleiman. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ****************************************************************
    // Initializing variables that will pull from the firebase database
    // ****************************************************************
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var redPepperoniSpecial: UILabel!
    @IBOutlet weak var redPepperSpecial: UILabel!
    @IBOutlet weak var redRoasterSpecial: UILabel!
    @IBOutlet weak var jendysSpecial: UILabel!
    @IBOutlet weak var shootersSpecial: UILabel!
    @IBOutlet weak var downtownerSpecial: UILabel!
    @IBOutlet weak var atticSpecial: UILabel!
    @IBOutlet weak var taproomSpecial: UILabel!
    @IBOutlet weak var shipleysSpecial: UILabel!
    
    let pickerData = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    // ************************************************************************************
    // Button functionality to bring up restaurants specific page 
    //  - Upon click of the restaurant, their specific view controller will be instantiated
    // ************************************************************************************
    @IBAction func onClickRedPepperoni(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "redPepperoniController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickRedPepper(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "redPepperController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickRedRoaster(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "redRoasterController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickJendys(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "jendysController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickShooters(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "shootersController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickDowntowner(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "downtownerController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickAttic(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "atticController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickTaproom(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "taproomController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickShipleys(_ sender: UIButton) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "shipleysController"))! as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    // ********************************************************************
    // Set ups the picker and the data for the specials page
    //  - Sets the intial day to sunday (upon pulling up this page, sundays
    //    will be initially displayed as default)
    // ********************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myPicker.dataSource = self
        myPicker.delegate = self
        
        //git myLabel.text = "Sunday"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Delegates and data sources
    //**********************************
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = pickerData[row]
        viewWillAppear(true)
    }
    
    // **********************************
    // Altering the font of my pickerview
    // **********************************
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Papyrus", size: 20.0)!])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    // ****************************************************************
    // Populate the Specials from the firebase database 
    //  - case for each day of the week 
    //  - the day of the week will be determined from the myLabel value 
    //    based on what day is selected in the picker
    // ****************************************************************
    func populateSpecials(store: String, storeLabel: UILabel) {
        let dayOfWeek: String = self.myLabel.text!
        
        let dbref = FIRDatabase.database().reference()
        
        switch dayOfWeek {
        case "Sunday":
            let dayRef = dbref.child("stores").child(store).child("days")
            dayRef.observeSingleEvent(of: .value, with:
                { (snapshot : FIRDataSnapshot) in
                    let snapshotValue = snapshot.value as? NSDictionary
                    storeLabel.text = snapshotValue?["sunday"] as? String
            })
        case "Monday":
            let dayRef = dbref.child("stores").child(store).child("days")
            dayRef.observeSingleEvent(of: .value, with:
                { (snapshot : FIRDataSnapshot) in
                    let snapshotValue = snapshot.value as? NSDictionary
                    storeLabel.text = snapshotValue?["monday"] as? String
            })
        case "Tuesday":
            let dayRef = dbref.child("stores").child(store).child("days")
            dayRef.observeSingleEvent(of: .value, with:
                { (snapshot : FIRDataSnapshot) in
                    let snapshotValue = snapshot.value as? NSDictionary
                    storeLabel.text = snapshotValue?["tuesday"] as? String
            })
        case "Wednesday":
            let dayRef = dbref.child("stores").child(store).child("days")
            dayRef.observeSingleEvent(of: .value, with:
                { (snapshot : FIRDataSnapshot) in
                    let snapshotValue = snapshot.value as? NSDictionary
                    storeLabel.text = snapshotValue?["wednesday"] as? String
            })
        case "Thursday":
            let dayRef = dbref.child("stores").child(store).child("days")
            dayRef.observeSingleEvent(of: .value, with:
                { (snapshot : FIRDataSnapshot) in
                    let snapshotValue = snapshot.value as? NSDictionary
                    storeLabel.text = snapshotValue?["thursday"] as? String
            })
        case "Friday":
            let dayRef = dbref.child("stores").child(store).child("days")
            dayRef.observeSingleEvent(of: .value, with:
                { (snapshot : FIRDataSnapshot) in
                    let snapshotValue = snapshot.value as? NSDictionary
                    storeLabel.text = snapshotValue?["friday"] as? String
            })
        case "Saturday":
            let dayRef = dbref.child("stores").child(store).child("days")
            dayRef.observeSingleEvent(of: .value, with:
                { (snapshot : FIRDataSnapshot) in
                    let snapshotValue = snapshot.value as? NSDictionary
                    storeLabel.text = snapshotValue?["saturday"] as? String
            })
        default:
            let dayRef = dbref.child("stores").child(store).child("days")
            dayRef.observeSingleEvent(of: .value, with:
                { (snapshot : FIRDataSnapshot) in
                    let snapshotValue = snapshot.value as? NSDictionary
                    storeLabel.text = snapshotValue?["sunday"] as? String
            })
        }
    }
    
    // ***************************************************************************
    // Populate the name of the stores from the firebase database
    // Not currently using after I switched the name labels to buttons
    // But this is a helpful function so I want to keep it for possible future use
    // ***************************************************************************
    func populateName(store: String, storeLabel: UILabel) {
        let dbref = FIRDatabase.database().reference()
        let ref = dbref.child("stores").child(store)
        ref.observeSingleEvent(of: .value, with:
            { (snapshot : FIRDataSnapshot) in
                let snapshotValue = snapshot.value as? NSDictionary
                storeLabel.text = snapshotValue?["name"] as? String
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
        self.viewDidAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // ************************************
        // Populting specials based on store ID 
        // ************************************
        populateSpecials(store: "d0VHcDyzDjSzFv1MtdSDUFakoaq1", storeLabel: redPepperoniSpecial)
        
        populateSpecials(store: "FWOjbbNYRmT78Y5SqhFLEiyV06G2", storeLabel: redPepperSpecial)
        
        populateSpecials(store: "8CFh2lafUyb0x00liB6FZHvLbDs1", storeLabel: redRoasterSpecial)
        
        populateSpecials(store: "R7OUYuAkl9Xv5UDrrudKniDJIxD2", storeLabel: jendysSpecial)
        
        populateSpecials(store: "oWH6ecCfK8aUJAGBBt3zBCUabQl2", storeLabel: shootersSpecial)
        
        populateSpecials(store: "QUzrBGxOakUDn25PwDoubxZFax03", storeLabel: downtownerSpecial)
        
        populateSpecials(store: "dmj5b8ljkqZul3UgZ6fyHpYOfkc2", storeLabel: atticSpecial)
        
        populateSpecials(store: "WR4KxIszohOE1g7YKx8JFUL9XNh2", storeLabel: taproomSpecial)
        
        populateSpecials(store: "xB41cKqDv9dZvYVxUwKPB34AgOI3", storeLabel: shipleysSpecial)
        
    }
    
}

