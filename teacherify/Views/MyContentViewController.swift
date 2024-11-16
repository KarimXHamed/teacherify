//
//  MyContentViewController.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit

class MyContentViewController: UIViewController {
    var currentLesson:lesson?
    var flashcards:[quiz]?
    var lesson:String?
    var position2:String?
    var currentLevel2:String?
    let scrollView = UIScrollView()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        lesson=currentLesson!.text
        setupScrollAndStackView()
        setUpUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        }
    func setupScrollAndStackView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 25).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.addSubview(stackView)
        scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        
    }
    func setUpUI(){
        //setup Background
        let backgroundImage = UIImageView(frame: self.view.bounds)
             backgroundImage.image = UIImage(named: "photo_5881715519122428151_y.jpg")
             backgroundImage.contentMode = .scaleAspectFill
             self.view.addSubview(backgroundImage)
             self.view.sendSubviewToBack(backgroundImage)
        
        flashcards=currentLesson?.quizes
       let myLesson=LessonView()
        myLesson.delegate=self
        myLesson.frontText="tap to see your lesson"
        myLesson.backText=lesson!
        myLesson.lessonText.text="tap to see your lesson"
        myLesson.lessonID="\(position2!) lesson"
        myLesson.currentLevel3=currentLevel2
        myLesson.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(myLesson)
        myLesson.widthAnchor.constraint(equalToConstant: 250).isActive = true
        myLesson.heightAnchor.constraint(equalToConstant: 300).isActive = true
        myLesson.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
        myLesson.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        for flashcard in flashcards! {
            var i=0
            let quiz = FlashcardView()
            quiz.delegate=self
            quiz.textLabel.text=flashcard.myQuiz[i].question
            quiz.frontText = flashcard.myQuiz[i].question
            quiz.backText = flashcard.myQuiz[i].answer
            quiz.correctAnswer = flashcard.myQuiz[i].answer
            quiz.quizID="\(position2!) quiz"
            quiz.currentLevel4=currentLevel2
            quiz.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(quiz)
            
            quiz.widthAnchor.constraint(equalToConstant: 250).isActive = true
            quiz.heightAnchor.constraint(equalToConstant: 250).isActive = true
            quiz.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
            quiz.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
            i+=1
            
        }
       
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }

}
