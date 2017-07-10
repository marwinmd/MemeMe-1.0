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
    
    
    @IBOutlet weak var tf_top: UITextField!
    @IBOutlet weak var tf_bottom: UITextField!
    @IBOutlet weak var bt_getFromLib: UIBarButtonItem!
    @IBOutlet weak var bt_getFromCam: UIBarButtonItem!
    @IBOutlet weak var iv_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleTextField(textfield: tf_top, caption: "TOP")
        styleTextField(textfield: tf_bottom, caption: "BOTTOM")
        
        iv_image.backgroundColor = UIColor.darkGray
        
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
    
    public func styleTextField(textfield: UITextField, caption: String){
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -1.0]
        
        textfield.defaultTextAttributes = memeTextAttributes
        textfield.textAlignment = NSTextAlignment.center
        textfield.text = caption
        

    }
}

