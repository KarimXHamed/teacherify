//
//  LessonsViewController.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit

class LessonsViewController: UITableViewController {
    var selectedContent:String?
    var selectedLessons:[lesson]=[]
    var position1:String?
    var currentLevel1:String?
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
        return selectedLessons.count
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           cell.textLabel?.text=selectedLessons[indexPath.row].name
           cell.layer.cornerRadius=10
           return cell
       }
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let lesson = selectedLessons[indexPath.row]
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyContentViewController") as! MyContentViewController
           vc.currentLesson=lesson
           vc.position2="\(position1!) \(lesson.name)"
           vc.currentLevel2=currentLevel1
         
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
    

}
