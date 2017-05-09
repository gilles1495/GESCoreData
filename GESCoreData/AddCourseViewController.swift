//
//  AddCourseViewController.swift
//  GESCoreData
//
//  Created by gilles Goncalves on 06/05/2017.
//  Copyright © 2017 gilles et julien. All rights reserved.
//

import UIKit
import CoreData

class AddCourseViewController: UIViewController {

    
    @IBOutlet weak var nameAddCourse: UITextField!
    @IBOutlet weak var cursusAddCourse: UITextField!
    @IBOutlet weak var messageDiv: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Ajouter une matière"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCourse(_ sender: Any) {
        if nameAddCourse.text != "" && cursusAddCourse.text != "" {
            if let context = CoreDataManager.shared.context{
                
                let fr: NSFetchRequest<Course> = Course.fetchRequest()
                fr.predicate = NSPredicate(format: "name == %@ AND grade == %@", nameAddCourse.text!,cursusAddCourse.text!)
                do {
                    let f = try context.fetch(fr)
                    if f.capacity == 0 {
                        let c = Course(context: context)
                        c.name = nameAddCourse.text
                        c.grade = cursusAddCourse.text
                    
                        do{
                            try context.save()
                            print(c)
                        }catch{
                            fatalError("Failed to save new COURSE: \(error)")
                        }
                    }
                    let homeViewController = HomeViewController()
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                    
                } catch {
                    fatalError("Failed to fetch COURSE: \(error)")
                }
                
                
            }else{
                FileUtils.afficheMsg(label:messageDiv,msg: "Erreur rencontré lors dE l'insertion dans coredata", color: UIColor.red)
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
