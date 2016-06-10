//
//  RequiredValidator.swift
//  Pods
//
//  Created by Tom Knapen on 10/06/16.
//
//

import Foundation

class RequiredValidator: Validator {
	
	let msg: String?
	
	init(_ message: String? = nil) {
		msg = message
	}
	
	func message() -> String? {
		return self.msg
	}
	
	func evaluate(str: String?, _ valid: (String? -> Void)?, _ invalid: (String? -> Void)?) -> Void {
		guard let str = str where str.characters.count > 0 else {
			if let invalid = invalid {
				invalid(str)
			}
		}
		
		if let valid = valid {
			valid(str)
		}
	}
	
}