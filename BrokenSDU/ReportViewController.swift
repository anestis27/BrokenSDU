//
//  ReportViewController.swift
//  BrokenSDU
//
//  Created by Emil Frisk on 23/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class ReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var dataController: DataController?
    var view_: ReportView?
    var userId = FireBase.getUserID()
    var room: String?
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        view_ = self.view as? ReportView
    }
    
    @IBAction func takePicture() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            view_?.imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitReport() {
        let _ = dataController?.createReport(description: (view_?.descriptionTextField.text)!, image: (view_?.imageView.image?.pngData())!, room: (room)!, timestamp: Date(), title: (view_?.titleTextField.text)!, userId: userId)
        dataController?.saveContext()
        
        room = "168"
        
        do {
            if let fileURL = Bundle.main.path(forResource: "sound.mp3", ofType: nil) {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
        
        let ans = FireBase.createReport(description: (view_?.descriptionTextField.text)! ,room: (room)!,timestamp: Date() , title: (view_?.titleTextField.text)!, userId: userId)

        
        if (ans){
            let alert = UIAlertController(title:"Message",message: "Your report is submitted", preferredStyle:UIAlertController.Style.alert);
            let okAction = UIAlertAction (title:"Ok", style: UIAlertAction.Style.default, handler:nil);
            alert.addAction(okAction);
            self.present(alert, animated:true, completion:nil);
        }else{
            let alert = UIAlertController(title:"Alert",message: "Something went wrong!", preferredStyle:UIAlertController.Style.alert);
            let okAction = UIAlertAction (title:"Ok", style: UIAlertAction.Style.default, handler:nil);
            alert.addAction(okAction);
            self.present(alert, animated:true, completion:nil);
        }
    }
}
