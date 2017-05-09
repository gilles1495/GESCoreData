//
//  HomeViewController.swift
//  GESCoreData
//
//  Created by gilles Goncalves on 18/04/2017.
//  Copyright © 2017 gilles et julien. All rights reserved.
//

import UIKit
import CoreData


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var coursesList: UITableView!
    var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MyGES"
        
        let rightNavButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(loadCourseForm(sender:)))
        
        navigationItem.rightBarButtonItem = rightNavButton
        
        let coursesList = UITableView(frame: view.bounds)
        view.addSubview(coursesList)
        self.coursesList = coursesList
        
        coursesList.delegate = self
        coursesList.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCourseForm(sender: Any) {
        let addCourseViewController = AddCourseViewController()
        self.navigationController?.pushViewController(addCourseViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let context = CoreDataManager.shared.context{
            
            let fr: NSFetchRequest<Course> = Course.fetchRequest()
            do {
                let f = try context.fetch(fr)
                
                for elem in f{
                    courses.append(elem)
                    
                }
            } catch {
                fatalError("Failed to fetch COURSE: \(error)")
            }
        }else{
            print("error")
        }
        coursesList.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        courses = []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let courseViewController = CourseViewController()
        courseViewController.thisCourse = courses[indexPath.row]
        self.navigationController?.pushViewController(courseViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right course
        let course = courses[indexPath.row]
        
        // Reuse a cell
        let cellIdentifier = "CourseCell"
        let cell = coursesList.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        // Adding the right informations
        cell.textLabel?.text = course.name
        cell.detailTextLabel?.text = course.grade
        
        
        // Returning the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
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
