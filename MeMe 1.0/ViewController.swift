//
//  ViewController.swift
//  MeMe 1.0
//
//  Created by Marwin Wiechert on 08.07.17.
//  Copyright © 2017 CleanUp. All rights reserved.
//

import UIKit

class ViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
      let imagePicker = UIImagePickerController()
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -1.0]
    
    @IBOutlet weak var tf_top: UITextField!
    @IBOutlet weak var tf_bottom: UITextField!
    @IBOutlet weak var bt_getFromLib: UIBarButtonItem!
    @IBOutlet weak var bt_getFromCam: UIBarButtonItem!
    @IBOutlet weak var bt_share: UIBarButtonItem!
    @IBOutlet weak var iv_image: UIImageView!
    @IBOutlet weak var tb_sources: UIToolbar!
    @IBOutlet weak var nv_navigation: UINavigationBar!
    
    @IBAction func ac_share(_ sender: Any) {
        
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.saveMeme(memedImage: memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        //present view controller
        present(activityController, animated: true, completion: nil)
        
    }
    
    @IBAction func ac_cancel(_ sender: Any) {
       
        styleTextField(textfield: tf_top, caption: "TOP")
        styleTextField(textfield: tf_bottom, caption: "BOTTOM")
        iv_image.image = nil
        
    }
    
    @IBAction func ac_getFromLib(_ sender: Any) {
       
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func ac_getFromCam(_ sender: Any) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bt_share.isEnabled = false
        
        styleTextField(textfield: tf_top, caption: "TOP")
        styleTextField(textfield: tf_bottom, caption: "BOTTOM")
        
        
        iv_image.backgroundColor = UIColor.darkGray
        bt_getFromCam.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        
        info: [String : Any]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            iv_image.image = image
            bt_share.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    public func styleTextField(textfield: UITextField, caption: String){
        
        textfield.defaultTextAttributes = memeTextAttributes
        textfield.textAlignment = NSTextAlignment.center
        textfield.text = caption
        textfield.delegate = self
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        if tf_top.isEditing {
            return
        }
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(_ notification:Notification){
        
        if tf_bottom.isEditing {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
       
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func generateMemedImage() -> UIImage {
    
        nv_navigation.isHidden = true
        tb_sources.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        

        nv_navigation.isHidden = false
        tb_sources.isHidden = false
        
        return memedImage
    
    }
    
    func saveMeme(memedImage: UIImage) {
        
        _ = Meme(topText: tf_top.text!, bottomText: tf_bottom.text!, image: iv_image.image!, memedImage: memedImage)
    }

    
}
