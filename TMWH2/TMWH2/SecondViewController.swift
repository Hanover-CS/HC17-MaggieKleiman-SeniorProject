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
    @IBOutlet weak var storeSpecials: UILabel!
    @IBOutlet weak var storeName: UILabel!
    
    let pickerData = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myPicker.dataSource = self
        myPicker.delegate = self
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        let dayOfWeek: String = myLabel.text!
        let dbref = FIRDatabase.database().reference()
        let ref = dbref.child("stores").child("7")
        ref.observeSingleEvent(of: .value, with:
        { (snapshot : FIRDataSnapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            self.storeName.text = snapshotValue?["name"] as? String
            //self.storeSpecials.text = snapshotValue?["days/monday"] as? String
        })
        let dayRef = dbref.child("stores").child("7").child("days")
        dayRef.observeSingleEvent(of: .value, with:
            { (snapshot : FIRDataSnapshot) in
                let snapshotValue = snapshot.value as? NSDictionary
                //self.storeName.text = snapshotValue?["name"] as? String
                self.storeSpecials.text = snapshotValue?["monday"] as? String
        })
        
    }
}

