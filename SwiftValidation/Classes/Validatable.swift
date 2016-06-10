//
//  Validatable.swift
//  Pods
//
//  Created by Tom Knapen on 06/06/16.
//
//

import Foundation

protocol Validatable {
	
	associatedtype This
	associatedtype T
	
	func validationSubject() -> T?
	func validate<V:Validator where V.Subject == T>(validators: [V], _ valid: (This -> Void)?, _ invalid: ((This, V) -> Void)?) -> Void
	
}

extension Validatable {
	
	func validate<V:Validator where V.Subject == T>(validators: [V], _ valid: (This -> Void)?, _ invalid: ((This, V) -> Void)?) -> Void
	{
		let subject = validationSubject()
		validateNext(subject, validators: validators, index: 0, valid, invalid)
	}
	
	func validateNext<V:Validator where V.Subject == T>(subject: T?, validators: [V], index: Int, _ valid: (This -> Void)?, _ invalid: ((This, V) -> Void)?) -> Void
	{
		if(index == validators.count) {
			if let valid = valid {
				valid(self as! This)
			}
			return
		}
		
		let validator = validators[index]
		validator.evaluate(subject, { (subject) in
			self.validateNext(subject, validators: validators, index: (index + 1), valid, invalid)
			}, { (subject) in
				if let invalid = invalid {
					invalid(self as! This, validator)
				}
		})
	}
	
}
