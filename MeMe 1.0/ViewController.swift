//
//  ViewController.swift
//  MeMe 1.0
//
//  Created by Marwin Wiechert on 08.07.17.
//  Copyright © 2017 CleanUp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()


    @IBOutlet weak var bt_getFromLib: UIBarButtonItem!
    @IBOutlet weak var bt_getFromCam: UIBarButtonItem!
    @IBOutlet weak var iv_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bt_getFromCam.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    @IBAction func ac_getFromLib(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func ac_getFromCam(_ sender: Any) {
        imagePicker .delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            iv_image.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }

}

