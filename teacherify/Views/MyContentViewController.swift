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
        self.title=currentLesson?.name
        lesson=currentLesson!.text
        setupScrollAndStackView()
        setUpUI()
       setupGestureRecognizers()
        setupKeyboardNotifications()
        }

    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
       DispatchQueue.global(qos: .background).async {
        if let backgroundImage = UIImage(named: "photo_5881715519122428151_y.jpg") {
            DispatchQueue.main.async {
                let backgroundImageView = UIImageView(frame: self.view.bounds)
                backgroundImageView.image = backgroundImage
                backgroundImageView.contentMode = .scaleToFill
                self.view.addSubview(backgroundImageView)
                self.view.sendSubviewToBack(backgroundImageView)
            }
        }
    }
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
        if let parentView = view {
            let parentWidth = parentView.bounds.width
            let spacing = (parentWidth - 250) / 2
            
            myLesson.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: spacing).isActive = true
            myLesson.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -spacing).isActive = true}
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
            if let parentView = view {
                let parentWidth = parentView.bounds.width
                let spacing = (parentWidth - 250) / 2
                
                quiz.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: spacing).isActive = true
                quiz.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -spacing).isActive = true}
            i+=1
            
        }
       
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            // Scroll to the last flashcard if needed
                    let lastFlashCardIndex = stackView.arrangedSubviews.count - 1
                    if lastFlashCardIndex >= 0 {
                        let lastFlashCard = stackView.arrangedSubviews[lastFlashCardIndex]
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }

}
