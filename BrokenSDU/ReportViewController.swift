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
    var dataController: DataControllerProtocol!
    var view_: ReportView?
    var userId = Auth.auth().currentUser!.uid
    var player = AVAudioPlayer()

    override func viewDidLoad() {
        view_ = self.view as? ReportView
        dataController = FirebaseDataController.instance
        playSound()
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
    
    func playSound() {
        let soundUrl = Bundle.main.url(forResource: "sound", withExtension: "wav")
        do {
            try player = AVAudioPlayer(contentsOf: soundUrl!)
        } catch  {
            print(error)
        }
        player.play()
    }
    
    @IBAction func submitReport() {
        let report = dataController.createReport(description: (view_?.descriptionTextField.text)!, image: (view_?.imageView.image?.jpegData(compressionQuality: 0.1))!, room: (view_?.roomTextField.text)!, timestamp: Date(), title: (view_?.titleTextField.text)!, userId: userId)
        dataController.saveReport(report: report)
        playSound()
        self.dismiss(animated: true, completion: nil)
    }
}
