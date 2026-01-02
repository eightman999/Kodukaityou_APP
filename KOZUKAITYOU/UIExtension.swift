//
//  UIExtension.swift
//  KOZUKAITYOU
//
//  Modern UI Extension for applying consistent styling
//
// © eightman 2005-2025. Furin-lab All rights reserved.

import UIKit

// MARK: - UIButton Modern Style Extension
extension UIButton {
    /// Apply modern rounded button style
    func applyModernStyle() {
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        clipsToBounds = false
    }

    /// Apply modern primary button style
    func applyPrimaryStyle() {
        applyModernStyle()
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    }

    /// Apply modern secondary button style
    func applySecondaryStyle() {
        applyModernStyle()
        backgroundColor = .systemGray6
        setTitleColor(.label, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
    }
}

// MARK: - UITextField Modern Style Extension
extension UITextField {
    /// Apply modern text field style
    func applyModernStyle() {
        borderStyle = .none
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        backgroundColor = .systemBackground

        // Add padding
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.height))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.height))
        rightViewMode = .always

        font = .systemFont(ofSize: 16)
    }
}

// MARK: - UIView Modern Style Extension
extension UIView {
    /// Apply modern card-like view style
    func applyCardStyle() {
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.1
        backgroundColor = .systemBackground
        clipsToBounds = false
    }

    /// Apply subtle rounded corners
    func applyRoundedCorners(radius: CGFloat = 12) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

// MARK: - UILabel Modern Style Extension
extension UILabel {
    /// Apply modern title style
    func applyTitleStyle() {
        font = .systemFont(ofSize: 24, weight: .bold)
        textColor = .label
    }

    /// Apply modern subtitle style
    func applySubtitleStyle() {
        font = .systemFont(ofSize: 17, weight: .medium)
        textColor = .secondaryLabel
    }

    /// Apply modern body style
    func applyBodyStyle() {
        font = .systemFont(ofSize: 15, weight: .regular)
        textColor = .label
    }
}
