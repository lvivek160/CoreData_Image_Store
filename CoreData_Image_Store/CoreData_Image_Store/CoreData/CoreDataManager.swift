//
//  CoreDataHelper.swift
//  CoreData_Image_Store
//
//  Created by PHN MAC 1 on 10/07/23.
//

import UIKit
import CoreData

final class CoreDataManager{
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
// MARK: - Save Student Data
    func saveStudent(student: StudentModel){
        let studentEntity = StudentEntity(context: context)
        studentEntity.firstName = student.firstName
        studentEntity.lastName = student.lastName
        studentEntity.email = student.email
        studentEntity.rollNumber = student.rollNumber
        studentEntity.imageId = student.imageId
        saveContext()
    }
    
// MARK: - GetSaved Student Data
    func fetchStudent()-> [StudentEntity]{
        var students: [StudentEntity] = []
        do{
            students = try context.fetch(StudentEntity.fetchRequest())
        }
        catch let error{
            print("Student Data fetching Error:- ",error)
        }
        return students
    }

// MARK: - Update Student Data
    func updateStudent(oldStudent: StudentEntity, newStudent: StudentModel){
        oldStudent.firstName = newStudent.firstName
        oldStudent.lastName = newStudent.lastName
        oldStudent.email = newStudent.email
        oldStudent.rollNumber = newStudent.rollNumber
        oldStudent.imageId = newStudent.imageId
        saveContext()
    }
    
// MARK: - Delete Student Data
    func deleteStudent(student: StudentEntity){
        //remove image from document directory
        let imageURL = URL.documentsDirectory.appending(components: student.imageId ?? "").appendingPathExtension("png")
        do{
            try FileManager.default.removeItem(at: imageURL)
        }
        catch let err{
            print("document directory image removing error:- ", err)
        }
        //remove data from coredata
        context.delete(student)
        saveContext()
    }
    
// MARK: - Others Common Functions
    private func saveContext(){
        do{
            try context.save()
        }
        catch let err{
            print("Saving Error:-", err)
        }
    }
}
