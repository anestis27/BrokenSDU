//
//  LogInViewController.swift
//  BrokenSDU
//
//  Created by Aa on 12/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func logInButton(_ sender: Any) {
        let userEmail = emailTextField.text;
        let userPassword = passwordTextField.text;
        if(userEmail != "" && userPassword != ""){
            Auth.auth().signIn(withEmail: userEmail!, password: userPassword!) { (user, error) in
                if (user != nil){
                    self.presentMainFrameScreen();
                }else{
                    var alert = UIAlertController(title:"Alert",message: "Something went wrong!", preferredStyle:UIAlertController.Style.alert);
                    let okAction = UIAlertAction (title:"Ok", style: UIAlertAction.Style.default, handler:nil);
                    alert.addAction(okAction);
                    self.present(alert, animated:true, completion:nil);                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.presentMainFrameScreen()
        }
    }
    
    func presentMainFrameScreen(){
        let st:UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let mainUI:MainFrameViewController = st.instantiateViewController(withIdentifier: "MainFrameViewController") as! MainFrameViewController
        let navigationController = UINavigationController(rootViewController: mainUI)
        self.present(navigationController, animated:  true, completion: nil)
    }
}
