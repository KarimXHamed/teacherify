//
//  ViewTracker.swift
//  teacherify
//
//  Created by karim hamed ashour on 11/6/24.
//

import UIKit

import Foundation

class ViewTracker {
    static let shared = ViewTracker()
    
    // Dictionary to track viewed lessons and quizzes by level name
    private var viewedLessons: [String: Set<String>] = [:] // Level name -> Set of viewed lesson names
    private var viewedQuizzes: [String: Set<String>] = [:] // Level name -> Set of viewed quiz IDs
    
    private init() {
        loadData()
    }
    
    // Load saved data from UserDefaults
    private func loadData() {
        if let savedLessons = UserDefaults.standard.dictionary(forKey: "viewedLessons") as? [String: [String]] {
            for (level, lessons) in savedLessons {
                viewedLessons[level] = Set(lessons)
            }
        }
        
        if let savedQuizzes = UserDefaults.standard.dictionary(forKey: "viewedQuizzes") as? [String: [String]] {
            for (level, quizzes) in savedQuizzes {
                viewedQuizzes[level] = Set(quizzes)
            }
        }
    }
    
    // Save current viewed lessons and quizzes to UserDefaults
    private func saveData() {
        let lessonsToSave = viewedLessons.mapValues { Array($0) }
        UserDefaults.standard.set(lessonsToSave, forKey: "viewedLessons")
        
        let quizzesToSave = viewedQuizzes.mapValues { Array($0) }
        UserDefaults.standard.set(quizzesToSave, forKey: "viewedQuizzes")
    }
    
    // Mark a lesson as viewed for a specific level
    func markLessonAsViewed(levelName: String, lessonName: String) {
        if viewedLessons[levelName] == nil {
            viewedLessons[levelName] = Set<String>()
        }
        viewedLessons[levelName]?.insert(lessonName)
        saveData()
    }
    
    // Mark a quiz as viewed for a specific level
    func markQuizAsViewed(levelName: String, quizId: String) {
        if viewedQuizzes[levelName] == nil {
            viewedQuizzes[levelName] = Set<String>()
        }
        viewedQuizzes[levelName]?.insert(quizId)
        saveData()
    }
    
    // Get the count of viewed lessons for a specific level
    func getViewedLessonCount(for levelName: String) -> Int {
        return viewedLessons[levelName]?.count ?? 0 // Returns 0 if levelName does not exist
    }
    
    // Get the count of viewed quizzes for a specific level
    func getViewedQuizCount(for levelName: String) -> Int {
        return viewedQuizzes[levelName]?.count ?? 0 // Returns 0 if levelName does not exist
    }
    
    // Check if a lesson has been viewed
    func hasLessonBeenViewed(levelName: String, lessonName: String) -> Bool {
        return viewedLessons[levelName]?.contains(lessonName) ?? false
    }
    
    // Check if a quiz has been viewed
    func hasQuizBeenViewed(levelName: String, quizId: String) -> Bool {
        return viewedQuizzes[levelName]?.contains(quizId) ?? false
    }
}
