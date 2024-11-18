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
//        setupActivityIndicator()
        setupBackground()
        

        activityIndicator.startAnimating()
      
        viewModel.fetchLanguageModel { [weak self] in
           
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.setupBackground()
                languages.append(contentsOf: [
                    LanguageModel(name: "SOON", levels: []),
                    LanguageModel(name: "SOON", levels: []),
                    LanguageModel(name: "SOON", levels: []),
                    LanguageModel(name: "SOON", levels: []),
                    LanguageModel(name: "SOON", levels: []),
                    LanguageModel(name: "SOON", levels: []),
                    LanguageModel(name: "SOON", levels: [])
                ])
                // Ensure that self.collectionView is not nil
               
                
                // Reload the collection view data
                self?.collectionView.reloadData()
            }
        }
    }
    func setupActivityIndicator() {
        self.view.bringSubviewToFront(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.color = .white  // Set the color of the indicator
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)  // Add activity indicator before the background image
    }

        func setupBackground(){
           
                let backgroundImage = UIImageView(frame: self.collectionView.bounds)
                backgroundImage.image = UIImage(named: "photo_5881715519122428151_y.jpg")
                backgroundImage.contentMode = .scaleToFill // scaleAspectFill

                self.collectionView.backgroundView = backgroundImage

               
            
            
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
        if indexPath.item == 0 {
            let language = languages[indexPath.item]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LevelsViewController") as! LevelsViewController
            vc.currentLanguage = language
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let alertController = UIAlertController(title: "Coming Soon", message: "More languages are coming soon!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}



