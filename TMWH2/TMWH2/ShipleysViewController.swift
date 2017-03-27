//
//  ShipleysViewController.swift
//  TMWH2
//
//  Created by Margaret Kleiman on 3/14/17.
//  Copyright © 2017 Margaret Kleiman. All rights reserved.
//

import UIKit
import MapKit

class ShipleysViewController: UIViewController {
    
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
        let url = NSURL(string: "tel://8122654215")!
        UIApplication.shared.openURL(url as URL)
    }
    
    // ****************************************
    // function to bring up restaurants webpage
    // ****************************************
    @IBAction func instantiateWebsite(_ sender: UIButton) {
        if let url = URL(string: "https://www.facebook.com/Shipleys-Tavern-200491190386/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    // ******************************************
    // Function to open up apple maps
    // and give directions to restaurant location
    // ******************************************
    @IBAction func openMaps(_ sender: UIButton) {
        let coordinate = CLLocationCoordinate2DMake(38.7359, -85.3800)
        let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.02))
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = "Shipley's Tavern"
        mapItem.openInMaps(launchOptions: options)
    }
}



