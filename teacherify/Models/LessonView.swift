//
//  LessonView.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit

class LessonView: UIView {
    @IBOutlet weak var lessonText: UILabel!
            var isFlipped=false
            var frontText="Click to view the lesson"
            var backText="???"
        var correctAnswer:String?
    var lessonID:String?
            weak var delegate:MyContentViewController!
    var isflipped=false
    var currentLevel3:String?
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
                    lessonText.text=frontText
                    
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
                    if let viewToAdd = bundle.loadNibNamed("Lesson", owner: self, options: nil) {
                        for view in viewToAdd {
                            if let contentView = view as? UIView {
                                
                                addSubview(contentView)
                                
                                
                                contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                contentView.layer.cornerRadius = 25
                                contentView.layer.masksToBounds = true
                                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                                        self.addGestureRecognizer(tapGesture)
                                        self.isUserInteractionEnabled = true
                                    
                                return
                            }
                        }
                    }
                
                }

    @objc func handleTap() {
        if !isFlipped{
            UIView.transition(with: self, duration: 0.5, options: .transitionCurlUp){
                self.lessonText.backgroundColor = .gray
                self.lessonText.text=self.backText
                self.isFlipped=true
                
            }}
        if ViewTracker.shared.hasLessonBeenViewed(levelName: currentLevel3!, lessonName: lessonID!) {
            print("This lesson has already been viewed.")
        } else {
            print("This lesson has not been viewed yet.")
            // Mark the lesson as viewed
            ViewTracker.shared.markLessonAsViewed(levelName: currentLevel3!, lessonName: lessonID!)
        }
          }
}
