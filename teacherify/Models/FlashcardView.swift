//
//  FlashcardView.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit

class FlashcardView: UIView {

        var isFlipped=false
        var frontText="???"
        var backText="???"
    var quizID:String?

        
        @IBOutlet weak var textLabel: UILabel!
        
        @IBOutlet weak var submitButton: UIButton!
        @IBOutlet weak var FlashCardTextField: UITextField!
    @IBOutlet weak var flashcardLabel: UILabel!
    var correctAnswer:String?
        var delegate:MyContentViewController!
    var currentLevel4:String?
        override func layoutSubviews() {
            super.layoutSubviews()
            for subview in subviews{
                if let contentView = subview as? UIView{
                    contentView.frame = self.bounds
                }
            }
        }
        
            override func awakeFromNib() {
                super.awakeFromNib()
                textLabel.text=frontText
            }
            override init(frame: CGRect) {
                super.init(frame: frame)
                self.commonInit()
                
            }
            
            required init?(coder: NSCoder) {
                super.init(coder: coder)
                self.commonInit()
                
            }
         
            
            private func commonInit() {
                let bundle = Bundle.main
                if let viewToAdd = bundle.loadNibNamed("Flashcard", owner: self, options: nil) {
                    for view in viewToAdd {
                        if let contentView = view as? UIView {
                            
                            addSubview(contentView)
                            
                            
                            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                            contentView.layer.cornerRadius = 25
                            contentView.layer.masksToBounds = true
                            submitButton.addTarget(self, action: #selector(submitIsTapped), for: .touchUpInside)
                                
                            return
                        }
                    }
                }
            
            }

    @objc func submitIsTapped(_ sender:UIButton){
        if isFlipped==false{
            guard let userAnswer = FlashCardTextField.text, let correctAnswer = correctAnswer else {return}
            if  userAnswer.lowercased() == correctAnswer.lowercased(){
                UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight){
                    self.flashcardLabel.backgroundColor = .green
                    self.textLabel.text="Well Done!!"
                    self.FlashCardTextField.isHidden=true
                    self.submitButton.isHidden=true
                    
                    
                }
            }else{
                UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight){
                    self.textLabel.text="Wrong!!"
                    self.flashcardLabel.backgroundColor = .red
                    self.FlashCardTextField.isHidden=true
                    self.submitButton.isHidden=true
                }
            }
        }
        if ViewTracker.shared.hasQuizBeenViewed(levelName: currentLevel4!, quizId: quizID!) {
            print("This quiz has already been viewed.")
        } else {
            print("This quiz has not been viewed yet.")
            // Mark the quiz as viewed
            ViewTracker.shared.markQuizAsViewed(levelName: currentLevel4!, quizId: quizID!)
        }
       
        isFlipped=true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         submitIsTapped(submitButton)
            FlashCardTextField.resignFirstResponder()
         return true
     }
        }

