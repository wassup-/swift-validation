//
//  AsyncValidator.swift
//  Pods
//
//  Created by Tom Knapen on 07/06/16.
//
//

import Foundation

class StringValidator: Validator {
	
	associatedtype T
	
	typealias Evaluator = (T? -> Bool);
	
	let evaluator: Evaluator!
	let msg: String?
	
	init(evaluator: Evaluator, _ message: String? = nil) {
		self.evaluator = { (subject, valid, invalid) in
			let res = evaluator(subject)
			if let valid = valid where res = true {
				valid(subject)
			} else if let invalid = invalid where res = false {
				invalid(subject)
			}
		}
		msg = message
	}
	
	init(evaluators: [Evaluator]?, _ message: String? = nil) {
		if let evaluators = evaluators {
			for evaluator in evaluators {
				
			}
		}
		msg = message
	}
	
	func message() -> String? {
		return self.msg
	}
	
	func evaluate(subject: T?, _ valid: (T? -> Void)?, _ invalid: (T? -> Void)?) -> Void {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
			evaluator(subject, valid, invalid)
		}
	}
	
}