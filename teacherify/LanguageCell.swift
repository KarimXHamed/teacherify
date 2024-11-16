//
//  LanguageCell.swift
//  teacherify
//
//  Created by karim hamed ashour on 10/21/24.
//

import UIKit

class LanguageCell: UICollectionViewCell {
    @IBOutlet weak var languageLabel: UILabel!
    private var gradientLayer: CAGradientLayer?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configure the label
        languageLabel.numberOfLines = 0 // Allow multiple lines
        languageLabel.lineBreakMode = .byWordWrapping // Wrap text
    }
      override func layoutSubviews() {
          super.layoutSubviews()	
          setupGradientLayer()
      }

      private func setupGradientLayer() {
          // Remove existing gradient layer if it exists
          gradientLayer?.removeFromSuperlayer()

          // Create a new gradient layer
          gradientLayer = CAGradientLayer()
          gradientLayer?.colors = [UIColor.systemPink.cgColor, UIColor.systemOrange.cgColor]
          gradientLayer?.startPoint = CGPoint(x: 0, y: 0.5)
          gradientLayer?.endPoint = CGPoint(x: 1, y: 0.5)
          gradientLayer?.frame = bounds // Use bounds here

          // Set corner radius
          gradientLayer?.cornerRadius = layer.cornerRadius

          // Insert the gradient layer
          if let gradientLayer = gradientLayer {
              layer.insertSublayer(gradientLayer, at: 0)
          }
      }
    
}
