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
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        guard let collectionView = self.tableView else { return }
        
        // Create and set the background image
        let backgroundImage = UIImageView(frame: collectionView.bounds)
        backgroundImage.image = UIImage(named: "photo_5881715519122428151_y.jpg")
        backgroundImage.contentMode = .scaleAspectFill
        
        // Set the background view
        collectionView.backgroundView = backgroundImage
 
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
        return selectedLessons.count
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           cell.textLabel?.textColor = .white
           cell.textLabel?.text=selectedLessons[indexPath.row].name
           // Set the accessory type to show an arrow
           cell.accessoryType = .disclosureIndicator
                  
                  // Optional: Set corner radius for the cell
           cell.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
           cell.layer.cornerRadius = 10
  
           cell.layer.masksToBounds = true
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
