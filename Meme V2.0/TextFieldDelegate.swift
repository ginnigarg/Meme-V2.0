//
//  TextFieldDelegate.swift
//  Meme V2.0
//
//  Created by Guneet Garg on 29/03/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//


import Foundation
import UIKit

class TextFieldDelegate : NSObject, UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text=""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

