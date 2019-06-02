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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func getInfo(_ sender: Any)
    {
        oldTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(getTheGoods),userInfo: nil, repeats: true)
    }
    
    @IBAction func halt(_ sender: Any)
    {
        oldTimer?.invalidate()
    }
    
    @objc func getTheGoods()
    {
        let downloadURL = URL(string: "http://10.0.0.163:9811")!
        
            do
            {
                let contents = try String(contentsOf:downloadURL, encoding: .utf8)
                print(contents)
            }
            catch let error as NSError
            {
                print("Error: \(error)")
            }
    }
    
    
}

