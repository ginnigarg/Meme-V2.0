//
//  ViewController.swift
//  Meme V2.0
//
//  Created by Guneet Garg on 29/03/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//
import UIKit

class MemeMakerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var choosePhotoBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navToolBar: UIToolbar!
    
    
    var countTopEdits = 0
    var countBottomEdits = 0
    var meme: MemeStruct?
    
    let textDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomTextField.delegate = textDelegate
        self.topTextField.delegate = textDelegate
        configTextFields()
        
    }
    
    let textStyles:[String : Any] = [
        NSAttributedString.Key.strokeColor.rawValue : UIColor.black,
        NSAttributedString.Key.foregroundColor.rawValue : UIColor.white,
        NSAttributedString.Key.font.rawValue : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth.rawValue : -3,
        ]
    
    func configTextField(text:String, textField:UITextField) {
        textField.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(textStyles)
        textField.textAlignment = .center
        textField.text! = text
        textField.delegate = textDelegate
    }
    
    private func configTextFields() {
        configTextField(text: "TOP", textField: topTextField)
        configTextField(text: "BOTTOM", textField: bottomTextField)
    }
    
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        presentImageViewWithSource(sourceType: .photoLibrary)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        presentImageViewWithSource(sourceType: .camera)
        
    }
    
    func presentImageViewWithSource(sourceType: UIImagePickerController.SourceType) {
        let image = UIImagePickerController()
        image.sourceType = sourceType
        image.delegate = self
        present(image, animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = imagePickerView.image != nil
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let picker = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = picker
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        choosePhotoBar.isHidden=true
        navToolBar.isHidden=true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Enabling the toolbar and navigation bar again
        choosePhotoBar.isHidden=false
        navToolBar.isHidden=false
        return memedImage
    }
    
    func save() {
        meme = MemeStruct(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())

        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if let meme = meme{
            appDelegate.meme.append(meme)
        }
    }
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func bottomFieldDidFinshEditing(_ sender: Any) {
        view.frame.origin.y = 0
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func shareItem(_ sender: Any) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, completed, items, error in
            if completed{
                self.save()
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
           _ =  navigationController?.popToRootViewController(animated: true)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
