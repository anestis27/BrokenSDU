//
//  ReportViewController.swift
//  BrokenSDU
//
//  Created by Emil Frisk on 23/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var dataController: DataController?
    var view_: ReportView?
    var userId = "userId"
    var room: String?
    
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
        
        // TODO: probably we wan't to segue somewhere after this
    }
}
