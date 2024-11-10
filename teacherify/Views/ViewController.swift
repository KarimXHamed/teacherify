//
//  ViewController.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/20/24.
//


import UIKit
import FirebaseFirestore
var languages:[LanguageModel]=[frenchLanguageModel]
var frenchLanguageModel:LanguageModel=LanguageModel(name: "", levels: [])
let viewModel=FetchLanguageModel()
class ViewController: UICollectionViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        activityIndicator.startAnimating()
        viewModel.fetchLanguageModel { [weak self] in
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.collectionView.reloadData()
                
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Language", for: indexPath) as? LanguageCell else {
            fatalError("unable to deque language cell")
        }
        cell.languageLabel.text=languages[indexPath.item].name
        cell.layer.cornerRadius=10

        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let language = languages[indexPath.item]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LevelsViewController") as! LevelsViewController
        vc.currentLanguage=language
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



