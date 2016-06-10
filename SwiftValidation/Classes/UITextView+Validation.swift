//
//  UITextView+Validation.swift
//  Pods
//
//  Created by Tom Knapen on 06/06/16.
//
//

import UIKit

extension UITextView: Validatable {
	
	typealias This = UITextView
	
	func validationSubject() -> String? {
		return text
	}
	
}