//
//  ViewController.swift
//  pickImage
//
//  Created by Bayan Zomarah on 11/12/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
   
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var Top: UITextField!
    @IBOutlet weak var Bottom: UITextField!
    @IBOutlet weak var spaceButton: UIBarButtonItem!
    @IBOutlet weak var toolbar2: UIToolbar!
    @IBOutlet weak var galleryButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                target: nil,
                                action: nil);
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
      
        
        customizeTextField(textField: Top , defaultText: "Top")
        customizeTextField(textField: Bottom, defaultText: "Bottom")
        
       // toolbar.items = [share, space, spaceButton ]
        toolbar2.items = [space, space, cameraButton,space, galleryButton ,space, space]
       // toolbar.backgroundColor = UIColor.clear
        toolbar2.backgroundColor = UIColor.clear
        
        share.isEnabled = false
    
        #if targetEnvironment(simulator)
        cameraButton.isEnabled = false
        #else
        cameraButton.isEnabled = true
        #endif
        
    }

   @IBAction func Cancel(_ sender: Any) {
       imageView.image = nil
       Top.text = "Top"
       Bottom.text = "Bottom"
       share.isEnabled = false
      dismiss(animated: true, completion: nil)
    }
    
    func GalleryOrCamera(  source: UIImagePickerController.SourceType, sourceType: String) {
       let pickerController = UIImagePickerController()
       if sourceType == "camera" {
        pickerController.allowsEditing = false }
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
        share.isEnabled = true
        
    }
    @IBAction func Gallery(_ sender: Any) {
        GalleryOrCamera(source: .photoLibrary, sourceType: "photoLibrary")
        
    }
    
    
    @IBAction func Camera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            GalleryOrCamera(source: .camera, sourceType: "camera")
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel( picker: UIImagePickerController ){
         share.isEnabled = false
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(Top.isEditing){
            Top.text = ""}
        if(Bottom.isEditing){
            Bottom.text = ""}
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:  UIWindow.keyboardWillHideNotification , object: nil)
    }
    
   
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name:  UIWindow.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromHideKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name:  UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if Bottom.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func showOrHide( boolean: Bool ) {
        //toolbar.isHidden = boolean
        toolbar2.isHidden = boolean
    }
    
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        showOrHide(boolean: true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        showOrHide(boolean: false)
        return memedImage
    }
    
    func save() {
        // Create the meme
       let meme = Meme(topText: Top.text!, bottomText: Bottom.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func customizeTextField(textField: UITextField, defaultText: String) {
        let memeTextAttributes:[NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black ,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -3.0]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.textAlignment = .center
        textField.text = defaultText
        textField.delegate = self
    }
    
    @IBAction func share(_ sender: Any) {
        
        let sharedImg =  [generateMemedImage()]
        let ac = UIActivityViewController(activityItems: sharedImg, applicationActivities: nil)
        
        
        ac.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                return
            }
            // User completed activity
            self.save()
        }
           present(ac, animated: true)
    }
    
}



