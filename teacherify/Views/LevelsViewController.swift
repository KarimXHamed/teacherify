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
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = cell.bounds // Set the frame to the bounds of the button
        gradientLayer.cornerRadius = cell.layer.cornerRadius // Optional: match the button's corner radius

        // Clear existing layers before adding the gradient
        cell.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        cell.layer.insertSublayer(gradientLayer, at: 0)
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
