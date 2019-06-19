//
//  ViewController.swift
//  Juice2
//
//  Created by Michael Edukonis on 5/28/19.
//  Copyright © 2019 Mike Edukonis. All rights reserved.
//

import UIKit
var go : Bool = true
class ViewController: UIViewController
{
    var oldTimer: Timer?
    var startDate: String!
    var startTime: String!
    var left: String!
    var right: String!
    var kwh: String!
    var measurements = [String]()
    var watts: String!
    
    @IBOutlet weak var leftSide: UITextField!
    @IBOutlet weak var rightSide: UITextField!
    @IBOutlet weak var killoWattHours: UITextField!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblWatts: UILabel!
    @IBOutlet weak var lblAmps: UILabel!
    @IBOutlet weak var lblBill: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        leftSide.text = "--"
        rightSide.text = "--"
        killoWattHours.text = "--"
        lblWatts.text = "--"
        lblAmps.text = "--"
        lblStartDate.text = "--"
        lblStartTime.text = "--"
        lblBill.text = "--"
        
    }

    @IBAction func getInfo(_ sender: Any)
    {
        oldTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(getTheGoods),userInfo: nil, repeats: true)
    }
    
    @IBAction func halt(_ sender: Any)
    {
        oldTimer?.invalidate()
        leftSide.text = "--"
        rightSide.text = "--"
        killoWattHours.text = "--"
        lblWatts.text = "--"
        lblAmps.text = "--"
        lblStartDate.text = "--"
        lblStartTime.text = "--"
        lblBill.text = "--"
        
    }
    
    @objc func getTheGoods()
    {
        let downloadURL = URL(string: "http://10.0.0.163:9811")!
        
            do
            {
                let contents = try String(contentsOf:downloadURL, encoding: .utf8)
                measurements = contents.components(separatedBy: ",")
                startDate = measurements[0]
                startTime = measurements[1]
                left = measurements[2]
                right = measurements[3]
                kwh = measurements[4]
                leftSide.text = left
                rightSide.text = right
                killoWattHours.text = kwh
                lblStartDate.text = startDate
                lblStartTime.text = startTime
                
                let l = Double(left)
                let r = Double(right)
                let w = Int((l! + r!) * 120)  //watts
                lblAmps.text =  String(format: "%.2f", (l! + r!))
                lblWatts.text = String(w)
                let subst = kwh!.dropLast()
                let dblkwh = Double(subst)
                lblBill.text = "$" + String(format: "%.2f", (dblkwh! * 0.1059385))
            }
                
            catch let error as NSError
            {
                print("Error: \(error)")
            }
    }
    
   
    
    
    
}

