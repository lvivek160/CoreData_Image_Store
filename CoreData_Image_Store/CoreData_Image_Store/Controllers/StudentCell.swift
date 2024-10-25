//
//  StudentCell.swift
//  CoreData_Image_Store
//
//  Created by PHN MAC 1 on 10/07/23.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentFullName: UILabel!
    @IBOutlet weak var studentEmail: UILabel!
    
    var student: StudentEntity?{
        didSet{
            configuration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configuration(){
        //configuration on here
        guard let student else { return }
        studentFullName.text = (student.firstName ?? "") + " " + (student.lastName ?? "")
        studentEmail.text = student.email ?? ""
        studentImage.getImageToDocumentDirectory(name: student.imageId ?? "")
    }
    
}


