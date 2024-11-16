//
//  ContentViewController.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class ContentViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var currentLevel:Level?
    var currentContent = ["Vocab","Grammer","Writing","Convo","Achievments"]
    var position:String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.title=currentLevel?.name
        collectionView.delegate = self
        collectionView.dataSource = self
        setupBackground()
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentContent.count
    }
  
    func setupBackground(){
       
            let backgroundImage = UIImageView(frame: self.collectionView.bounds)
            backgroundImage.image = UIImage(named: "photo_5881715519122428151_y.jpg")
            backgroundImage.contentMode = .scaleAspectFill

            self.collectionView.backgroundView = backgroundImage
}
    
    func achievmentsIsClicked() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let modalViewController = storyboard.instantiateViewController(withIdentifier: "AchievmentsVC") as? AchievmentsViewController else {
            return
        }
        
        // Set the modal presentation style to .pageSheet to use sheet presentation features
        modalViewController.modalPresentationStyle = .pageSheet
        
        // Set up the data for the modal view controller
        guard let levelName = self.currentLevel?.name else { return }
        let viewedLessonCount = ViewTracker.shared.getViewedLessonCount(for: levelName)
        let viewedQuizCount = ViewTracker.shared.getViewedQuizCount(for: levelName)
        let statement = "Viewed Lessons: \(viewedLessonCount)/12\ntaken Quizzes: \(viewedQuizCount)/12"
        modalViewController.statement1 = statement
        
        // After presenting, configure the sheet presentation controller
        if let sheet = modalViewController.sheetPresentationController {
            // Define the available detents
            sheet.detents = [ .medium(), .large()] // Include medium and large if needed
            // Set the initial detent to medium
            sheet.selectedDetentIdentifier = .medium // Change to .medium if you want it to start at medium
        present(modalViewController, animated: true) {
     
            }
        }
    }
override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Language", for: indexPath) as? LanguageCell else {
            fatalError("unable to deque language cell")
        }
        cell.languageLabel.text = currentContent[indexPath.item]
        cell.layer.cornerRadius=10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item==4{
            return CGSize(width: 375, height: 50)
        }
        return  CGSize(width: 120, height: 120)
    }

    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let level = currentLevel else {
            print("currentLevel is nil")
            return
        }
       
        
        switch currentContent[indexPath.item] {
            case "Vocab":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController
                vc.selectedLessons = level.vocabs
                vc.position1 = "\(position!) vocab"
                vc.currentLevel1 = currentLevel?.name
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "Grammer":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController
                vc.selectedLessons = level.grammers
                vc.position1 = "\(position!) grammer"
                vc.currentLevel1 = currentLevel?.name
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "Writing":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController
                vc.selectedLessons = level.writings
                vc.position1 = "\(position!) writing"
                vc.currentLevel1 = currentLevel?.name
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "Convo":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController
                vc.selectedLessons = level.convos
                vc.position1 = "\(position!) convo"
                vc.currentLevel1 = currentLevel?.name
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "Achievments":
            

                achievmentsIsClicked()
            
                collectionView.deselectItem(at: indexPath, animated: true)
            
            default:
                break
        }
    }
    
    }




