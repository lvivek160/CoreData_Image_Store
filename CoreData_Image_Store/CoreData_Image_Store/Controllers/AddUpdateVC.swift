//
//  AddUpdateVC.swift
//  CoreData_Image_Store
//
//  Created by PHN MAC 1 on 10/07/23.
//

import UIKit
import PhotosUI

class AddUpdateVC: UIViewController {
// MARK: - IBOutlets
    //textfields
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailIdTxt: UITextField!
    @IBOutlet weak var rollNumberTxt: UITextField!
    //Profile Image
    @IBOutlet weak var studentImage: UIImageView!
    //Btn
    @IBOutlet weak var save_UpdateBtn: UIButton!
    
    let coreDataHelper = CoreDataManager()
    var isUpdate: Bool = false
    var studentEntity: StudentEntity?
    var imageSelection: Bool = false
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
// MARK: - IBActions
    @IBAction func save_UpdateBtnAction(_ sender: UIButton) {
        guard let firstName = firstNameTxt.text, !firstName.isEmpty else {
            self.showAlert(message: "First Name should not be valid")
            return
        }
        guard let lastName = lastNameTxt.text, !lastName.isEmpty else {
            self.showAlert(message: "last Name should not be valid")
            return
        }
        guard let email = emailIdTxt.text, !email.isEmpty else {
            self.showAlert(message: "Email should not be valid")
            return
        }
        guard let rollNumber = rollNumberTxt.text, !rollNumber.isEmpty else {
            self.showAlert(message: "Roll Number should not be valid")
            return
        }
        if !imageSelection{
            self.showAlert(message: "Please select profile image")
            return
        }
        
        if isUpdate{
            //update data on here
            guard let studentEntity else {return}
            let student = StudentModel(
                firstName: firstName,
                lastName: lastName,
                email: email,
                rollNumber: rollNumber,
                imageId: studentEntity.imageId ?? "") //image name old image name assigned
            
            self.studentImage.saveImageToDocumentDirectory(imageName: studentEntity.imageId ?? "")
            self.coreDataHelper.updateStudent(oldStudent: studentEntity, newStudent: student)
        }
        else {
            //add new data on here
            let imageName = UUID().uuidString
            let student = StudentModel(
                firstName: firstName,
                lastName: lastName,
                email: email,
                rollNumber: rollNumber,
                imageId: imageName)

            studentImage.saveImageToDocumentDirectory(imageName: imageName)
            coreDataHelper.saveStudent(student: student)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Configurations
extension AddUpdateVC{
    private func configuration(){
        studentImage.layer.cornerRadius = self.studentImage.frame.width / 2.0
        if isUpdate{
            //Update Student Here
            self.firstNameTxt.text = self.studentEntity?.firstName
            self.lastNameTxt.text = self.studentEntity?.lastName
            self.emailIdTxt.text = self.studentEntity?.email
            self.rollNumberTxt.text = self.studentEntity?.rollNumber
            self.studentImage.getImageToDocumentDirectory(name: self.studentEntity?.imageId ?? "")
            self.imageSelection = true
            self.title = "Update Student"
            save_UpdateBtn.setTitle("Update", for: .normal)
        }
        else{
            //add New Student Here
            self.title = "Add Student"
            save_UpdateBtn.setTitle("Add", for: .normal)
        }
        //make image Clickable
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        studentImage.addGestureRecognizer(imageTap)
    }
    @objc func profileImageTapped(){
        //open Gallery here
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        self.present(pickerVC, animated: true)
    }

}

// MARK: - PHPicker ViewController Delegate
extension AddUpdateVC: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.dismiss(animated: true)
        let firstImageData = results.first
        //Use background Thread
        firstImageData?.itemProvider.loadObject(ofClass: UIImage.self){ image, error in
            guard let image = image as? UIImage else { return }
            DispatchQueue.main.async {
                self.studentImage.image = image
                self.imageSelection = true
            }
        }
    }
}
