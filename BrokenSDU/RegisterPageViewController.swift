//
//  RegisterPageViewController.swift
//  BrokenSDU
//
//  Created by Aa on 12/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!
    
    @IBAction func registerButton(_ sender: Any) {
        
        var userEmail = userEmailTextField.text;
        var userPassword = userPasswordTextField.text;
        var userRepeatPassword = userRepeatPasswordTextField.text;
        
        //Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty){
            displayAlert(ms:"All fields are required.")
            return;
        }
        
        //If password match
        if(userPassword != userRepeatPassword){
            displayAlert(ms:"Passwords do not match!")
            return;
        }
        
        //Store data
        Auth.auth().createUser(withEmail: userEmail!, password: userPassword!) { (user, error) in
            if(user != nil){
                //Display alert message
                var alert = UIAlertController(title:"Alert",message:"Registration is completed!", preferredStyle:UIAlertController.Style.alert);
                let okAction = UIAlertAction (title:"Ok", style: UIAlertAction.Style.default){
                    action in
                    self.dismiss(animated: true, completion: nil);
                }
                alert.addAction(okAction);
                self.present(alert, animated:true, completion:nil);
            }else{
                self.displayAlert(ms:"Something went wrong!");
            }
        }
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayAlert(ms:String){
        
        var alert = UIAlertController(title:"Alert",message:ms, preferredStyle:UIAlertController.Style.alert);
        let okAction = UIAlertAction (title:"Ok", style: UIAlertAction.Style.default, handler:nil);
        
        alert.addAction(okAction);
        self.present(alert, animated:true, completion:nil);
    }
}
