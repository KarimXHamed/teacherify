//
//  FetchLanguageModel.swift
//  teacherify
//
//  Created by karim hamed ashour on 11/6/24.
//

import UIKit
import FirebaseFirestore

class FetchLanguageModel: NSObject {
    func fetchLanguageModel(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("french").document("myLanguageModel")

        docRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                completion() // Call completion even if there's an error
            } else if let document = document, let data = document.data() {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let languageModel = try JSONDecoder().decode(LanguageModel.self, from: jsonData)
                    frenchLanguageModel = languageModel
                    languages = [frenchLanguageModel]
                    print("Language model fetched successfully: \(languageModel)")
                    completion() // Call completion after successful fetch
                } catch {
                    print("Error decoding language model: \(error)")
                    completion() // Call completion even if there's a decoding error
                }
            } else {
                print("Document does not exist")
                completion() // Call completion if the document does not exist
            }
        }
    }
}
