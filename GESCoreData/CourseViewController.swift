//
//  CourseViewController.swift
//  GESCoreData
//
//  Created by gilles Goncalves on 06/05/2017.
//  Copyright © 2017 gilles et julien. All rights reserved.
//

import UIKit
import CoreData

class CourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var studentsList: UITableView!
    var thisCourse: Course = Course()
    var students: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = thisCourse.name!+" "+thisCourse.grade!
        
        let rightNavButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(loadStudentForm(sender:)))
        
        navigationItem.rightBarButtonItem = rightNavButton
        
        let studentsList = UITableView(frame: view.bounds)
        view.addSubview(studentsList)
        //self.studentsList = studentsList
        
        studentsList.delegate = self
        studentsList.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadStudentForm(sender: Any) {
        let addStudentViewController = AddStudentViewController()
        addStudentViewController.studentCourse = thisCourse
        self.navigationController?.pushViewController(addStudentViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let context = CoreDataManager.shared.context{
            
            let fr: NSFetchRequest<Student> = Student.fetchRequest()
            do {
                let f = try context.fetch(fr)
                
                for elem in f{
                    if (elem.study?.contains(thisCourse))!{
                        students.append(elem)
                    }
                    
                }
            } catch {
                fatalError("Failed to fetch Student: \(error)")
            }
        }else{
            print("error")
        }
        studentsList.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        students = []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right course
        let course = students[indexPath.row]
        
        // Reuse a cell
        let cellIdentifier = "StudentCell"
        let cell = studentsList.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        // Adding the right informations
        cell.textLabel?.text = course.lastname
        cell.detailTextLabel?.text = course.firstname
        
        
        // Returning the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
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
