//
//  LevelsViewController.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class LevelsViewController: UICollectionViewController {
    var currentLanguage:LanguageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.title = currentLanguage?.name
     setupBackground()
        
       
    }
    func setupBackground(){
        // Ensure that self.collectionView is not nil
        guard let collectionView = self.collectionView else { return }
        
        // Create and set the background image
        let backgroundImage = UIImageView(frame: collectionView.bounds)
        backgroundImage.image = UIImage(named: "photo_5881715519122428151_y.jpg")
        backgroundImage.contentMode = .scaleAspectFill
        
        // Set the background view
        collectionView.backgroundView = backgroundImage
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentLanguage?.levels.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Language", for: indexPath) as? LanguageCell else {
            fatalError("unable to deque language cell")
        }
        cell.languageLabel.text = currentLanguage?.levels[indexPath.row].name
        cell.layer.cornerRadius=10
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let position=currentLanguage?.name
        let level = currentLanguage?.levels[indexPath.item]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        vc.currentLevel=level
        vc.position="\(position!) \(level!.name)"
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
