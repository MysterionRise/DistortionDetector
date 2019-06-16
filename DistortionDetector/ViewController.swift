//
//  ViewController.swift
//  DistortionDetector
//
//  Created by Konstantin on 13/04/2019.
//  Copyright © 2019 Konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var openCVLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    @IBAction func captureImg(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func checkOpenCVVersion(_ sender: Any) {
        openCVLabel.text = OpenCVWrapper.openCVVersionString()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        //        openCVLabel.text = String(OpenCVWrapper.containsChessBoard((info[.originalImage] as? UIImage)!))
        image.image = OpenCVWrapper.containsChessBoard((info[.originalImage] as? UIImage)!)
    }
    
    
}

