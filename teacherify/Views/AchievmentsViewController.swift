//  AchievmentsViewController.swift
//  teacherify
//
//  Created by karim hamed ashour on 11/16/24.
//

import UIKit

class AchievmentsViewController: UIViewController {
    
    @IBOutlet weak var achievmentsLabel: UILabel!
    @IBOutlet weak var achievmentsView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    var statement1:String?
    var statement2:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        achievmentsLabel.text=statement1
      
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
        doneButton.clipsToBounds = true
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
