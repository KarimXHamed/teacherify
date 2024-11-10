//
//  ContentViewController.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class ContentViewController: UICollectionViewController {
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var Achievments: UIButton!
    @IBOutlet weak var achievementsView: UIView!
    var currentLevel:Level?
    var effect:UIVisualEffect!
    var currentContent = ["Vocab","Grammer","Writing","Convo"]
    var position:String?
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.title=currentLevel?.name
        setupAchievementsButtonGradient()
        effect=visualEffect.effect
        visualEffect.effect=nil
        achievementsView.alpha = 0
        achievementsView.isHidden = true
        
    }
    private func setupAchievementsButtonGradient() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.frame = Achievments.bounds // Set the frame to the bounds of the button
            gradientLayer.cornerRadius = Achievments.layer.cornerRadius // Optional: match the button's corner radius

            // Clear existing layers before adding the gradient
        Achievments.layer.cornerRadius=10
            Achievments.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            Achievments.layer.insertSublayer(gradientLayer, at: 0)
        }

    func animateIn() {
        guard let levelName = currentLevel?.name else { return }
                let viewedLessonCount = ViewTracker.shared.getViewedLessonCount(for: levelName)
                let viewedQuizCount = ViewTracker.shared.getViewedQuizCount(for: levelName)
        secondaryLabel.text="Viewed Lessons: \(viewedLessonCount)/12\ntaken Quizzes: \(viewedQuizCount)/12"
        Achievments.isHidden=true
        // Show the achievements view
        achievementsView.isHidden = false
        achievementsView.center = self.view.center
        achievementsView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffect.effect = self.effect
            self.achievementsView.alpha = 1
            self.achievementsView.transform = CGAffineTransform.identity
        }
    }

    func animateOut() {
        Achievments.isHidden=false
        UIView.animate(withDuration: 0.4, animations: {
            self.achievementsView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.achievementsView.alpha = 0
            self.visualEffect.effect = nil
        }) { (completed) in
            self.achievementsView.isHidden = true
        }
    }

    @IBAction func achievmentsClicked(_ sender: Any) {
        animateIn()
    }
    @IBAction func doneClicked(_ sender: Any) {
        animateOut()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentContent.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Language", for: indexPath) as? LanguageCell else {
            fatalError("unable to deque language cell")
        }
        cell.languageLabel.text = currentContent[indexPath.item]
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
        guard let level = currentLevel else { return }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController
        switch currentContent[indexPath.item] {
            case "Vocab":
                vc.selectedLessons = level.vocabs
            vc.position1="\(position!) vocab"
            vc.currentLevel1=currentLevel?.name
            case "Grammer":
                vc.selectedLessons = level.grammers
            vc.position1="\(position!) grammer"
            vc.currentLevel1=currentLevel?.name
            case "Writing":
                vc.selectedLessons = level.writings
            vc.position1="\(position!) writing"
            vc.currentLevel1=currentLevel?.name
            case "Convo":
                vc.selectedLessons = level.convos
            vc.position1="\(position!) convo"
            vc.currentLevel1=currentLevel?.name
            default:
                break
            }

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }




