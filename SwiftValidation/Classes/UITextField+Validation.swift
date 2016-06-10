//
//  UITextField+Validation.swift
//  Pods
//
//  Created by Tom Knapen on 06/06/16.
//
//

import UIKit

extension UITextField: Validatable {
	
	typealias This = UITextField
	
	func validationSubject() -> String? {
		return text
	}
	
}