//
//  AddStudentViewController.swift
//  GESCoreData
//
//  Created by gilles Goncalves on 06/05/2017.
//  Copyright © 2017 gilles et julien. All rights reserved.
//

import UIKit
import CoreData

class AddStudentViewController: UIViewController {

    
    @IBOutlet weak var lastnameAddStudent: UITextField!
    @IBOutlet weak var firstnameAddStudent: UITextField!
    @IBOutlet weak var messageDiv: UILabel!
    var studentCourse:Course = Course()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Ajouter un élève"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addStudent(_ sender: Any) {
        if lastnameAddStudent.text != "" && firstnameAddStudent.text != "" {
            if let context = CoreDataManager.shared.context{
                
                let fr: NSFetchRequest<Student> = Student.fetchRequest()
                fr.predicate = NSPredicate(format: "lastname == %@ AND firstname == %@", lastnameAddStudent.text!,firstnameAddStudent.text!)
                do {
                    let f = try context.fetch(fr)
                    if f.capacity == 0 {
                        let s = Student(context: context)
                        s.lastname = lastnameAddStudent.text
                        s.firstname = firstnameAddStudent.text
                        s.addToStudy(studentCourse)
                        
                        do{
                            try context.save()
                            //print(s)
                        }catch{
                            fatalError("Failed to save new STUDENT: \(error)")
                        }
                    }
                    let courseViewController = CourseViewController()
                    courseViewController.thisCourse = studentCourse
                    self.navigationController?.pushViewController(courseViewController, animated: true)
                    
                } catch {
                    fatalError("Failed to fetch STUDENT: \(error)")
                }
                
                
            }else{
                FileUtils.afficheMsg(label:messageDiv,msg: "Erreur rencontré lors de l'insertion ", color: UIColor.red)
            }
            
        }else{
            FileUtils.afficheMsg(label:messageDiv,msg: "Vous n'avez pas remplie tous les champs", color: UIColor.red)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
