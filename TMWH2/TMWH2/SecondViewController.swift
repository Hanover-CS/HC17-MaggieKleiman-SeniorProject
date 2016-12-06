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

    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var redPepperoni: UILabel!
    @IBOutlet weak var redPepperoniSpecial: UILabel!
    
    @IBOutlet weak var redPepper: UILabel!
    @IBOutlet weak var redPepperSpecial: UILabel!
    
    @IBOutlet weak var redRoaster: UILabel!
    @IBOutlet weak var redRoasterSpecial: UILabel!
    
    @IBOutlet weak var jendys: UILabel!
    @IBOutlet weak var jendysSpecial: UILabel!
    
    @IBOutlet weak var shooters: UILabel!
    @IBOutlet weak var shootersSpecial: UILabel!

    @IBOutlet weak var downtowner: UILabel!
    @IBOutlet weak var downtownerSpecial: UILabel!
    
    @IBOutlet weak var attic: UILabel!
    @IBOutlet weak var atticSpecial: UILabel!
    
    @IBOutlet weak var taproom: UILabel!
    @IBOutlet weak var taproomSpecial: UILabel!
    
    @IBOutlet weak var shipleys: UILabel!
    @IBOutlet weak var shipleysSpecial: UILabel!
    
    let pickerData = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myPicker.dataSource = self
        myPicker.delegate = self
        
        myLabel.text = "Sunday"
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
    }
    
    //Altering the font of my pickerview
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Papyrus", size: 20.0)!])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    
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
    
    func populateName(store: String, storeLabel: UILabel) {
        let dbref = FIRDatabase.database().reference()
        let ref = dbref.child("stores").child(store)
        ref.observeSingleEvent(of: .value, with:
            { (snapshot : FIRDataSnapshot) in
                let snapshotValue = snapshot.value as? NSDictionary
                storeLabel.text = snapshotValue?["name"] as? String
        })

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        populateName(store: "0", storeLabel: redPepperoni)
        populateSpecials(store: "0", storeLabel: redPepperoniSpecial)
        
        populateName(store: "1", storeLabel: redPepper)
        populateSpecials(store: "1", storeLabel: redPepperSpecial)
        
        populateName(store: "2", storeLabel: redRoaster)
        populateSpecials(store: "2", storeLabel: redRoasterSpecial)
        
        populateName(store: "3", storeLabel: jendys)
        populateSpecials(store: "3", storeLabel: jendysSpecial)
        
        populateName(store: "4", storeLabel: shooters)
        populateSpecials(store: "4", storeLabel: shootersSpecial)
        
        populateName(store: "5", storeLabel: downtowner)
        populateSpecials(store: "5", storeLabel: downtownerSpecial)
        
        populateName(store: "6", storeLabel: attic)
        populateSpecials(store: "6", storeLabel: atticSpecial)
        
        populateName(store: "7", storeLabel: taproom)
        populateSpecials(store: "7", storeLabel: taproomSpecial)
        
        populateName(store: "8", storeLabel: shipleys)
        populateSpecials(store: "8", storeLabel: shipleysSpecial)
        
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        navigationItem.title = nil
    }

    
}

