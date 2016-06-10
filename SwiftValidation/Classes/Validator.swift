//
//  Validator.swift
//  Pods
//
//  Created by Tom Knapen on 06/06/16.
//
//

import Foundation

protocol Validator {
	
	associatedtype Subject
	
	func message() -> String?
	func evaluate(subject: Subject?, _ valid: (Subject? -> Void)?, _ invalid: (Subject? -> Void)?) -> Void
	
}

extension Validator {
	
	func evaluate(x: Subject?, _ block: ((Subject?, Bool) -> Void)?) -> Void {
		self.evaluate(x, { (x) in
			if let block = block {
				block(x, true)
			}
		}) { (x) in
			if let block = block {
				block(x, false)
			}
		}
	}
	
}
