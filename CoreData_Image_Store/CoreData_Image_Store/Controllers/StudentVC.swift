//
//  ViewController.swift
//  CoreData_Image_Store
//
//  Created by PHN MAC 1 on 10/07/23.
//

import UIKit

class StudentVC: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var studentTableView: UITableView!
    var students: [StudentEntity] = []
    let coreDataHelper = CoreDataManager()
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentTableView.register(StudentCell.nib, forCellReuseIdentifier: StudentCell.id)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.students = coreDataHelper.fetchStudent()
        self.studentTableView.reloadData()
    }

// MARK: - IBActions
    @IBAction func studentAddBtnClick(_ sender: Any) {
        let addVC = self.storyboard?.instantiateViewController(withIdentifier: AddUpdateVC.id) as! AddUpdateVC
        self.navigationController?.pushViewController(addVC, animated: true)
    }
}

// MARK: - tableView DataSources Methods
extension StudentVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = studentTableView.dequeueReusableCell(withIdentifier: StudentCell.id, for: indexPath) as? StudentCell else {
            fatalError(StudentCell.id + " Nib Not Found")
        }
        cell.student = self.students[indexPath.row]
        return cell
    }
}

// MARK: - tableView Delegates Methods
extension StudentVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.coreDataHelper.deleteStudent(student: self.students[indexPath.row])
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update") { _, _, _ in
            let updateVC = self.storyboard?.instantiateViewController(withIdentifier: AddUpdateVC.id) as! AddUpdateVC
            updateVC.studentEntity = self.students[indexPath.row]
            updateVC.isUpdate = true
            self.navigationController?.pushViewController(updateVC, animated: true)
        }
        update.backgroundColor = .systemIndigo
        return UISwipeActionsConfiguration(actions: [update])
    }
}
