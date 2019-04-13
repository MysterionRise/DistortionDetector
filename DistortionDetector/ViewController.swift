//
//  ViewController.swift
//  DistortionDetector
//
//  Created by Konstantin on 13/04/2019.
//  Copyright © 2019 Konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var openCVLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: Actions
    @IBAction func checkOpenCVVersion(_ sender: Any) {
        openCVLabel?.text = OpenCVWrapper.openCVVersionString()
    }
    

}

