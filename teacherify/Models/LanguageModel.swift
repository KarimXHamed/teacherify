//
//  LanguageModel.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit


struct LanguageModel:Codable {
    let name:String
    let levels:[Level]

}
struct Level:Codable{
let name:String
let vocabs:[lesson]
let grammers:[lesson]
let writings:[lesson]
let convos:[lesson]
    
}
struct lesson:Codable{
    let name:String
    let text:String
    let quizes:[quiz]
}

struct quiz:Codable{
    let myQuiz:[point]
    let score:Int
    
}
struct point:Codable{
let question:String
let answer:String
}





