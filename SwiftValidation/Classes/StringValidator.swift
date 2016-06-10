//
//  StringValidator.swift
//  Pods
//
//  Created by Tom Knapen on 06/06/16.
//
//

import Foundation

class StringValidator: Validator {
	
	let evaluator: ((String?, (String? -> Void)?, (String? -> Void)?) -> Void)!
	let msg: String?
	
	init(regex: String, _ message: String? = nil) {
		evaluator = { (str, valid, invalid) in
			let res = NSPredicate(format: "(SELF MATCHES %@)", regex).evaluateWithObject(str)
			if let valid = valid where res == true {
				valid(str)
			} else if let invalid = invalid where res == false {
				invalid(str)
			}
		}
		msg = message
	}
	
	init(length: Int, _ message: String? = nil) {
		evaluator = { (str, valid, invalid) in
			let res = NSPredicate(format: "(SELF.length == %i)", length).evaluateWithObject(str)
			if let valid = valid where res == true {
				valid(str)
			} else if let invalid = invalid where res == false {
				invalid(str)
			}
		}
		msg = message
	}
	
	init(minlength: Int, _ message: String? = nil) {
		evaluator = { (str, valid, invalid) in
			let res = NSPredicate(format: "(SELF.length >= %i)", minlength).evaluateWithObject(str)
			if let valid = valid where res == true {
				valid(str)
			} else if let invalid = invalid where res == false {
				invalid(str)
			}
		}
		msg = message
	}
	
	init(maxlength: Int, _ message: String? = nil) {
		evaluator = { (str, valid, invalid) in
			let res = NSPredicate(format: "(SELF.length <= %i)", maxlength).evaluateWithObject(str)
			if let valid = valid where res == true {
				valid(str)
			} else if let invalid = invalid where res == false {
				invalid(str)
			}
		}
		msg = message
	}
	
	init(minlength: Int, maxlength: Int, _ message: String? = nil) {
		evaluator = { (str, valid, invalid) in
			let res = NSPredicate(format: "(SELF.length >= %i) && (SELF.length <= %i)", minlength, maxlength).evaluateWithObject(str)
			if let valid = valid where res == true {
				valid(str)
			} else if let invalid = invalid where res == false {
				invalid(str)
			}
		}
		msg = message
	}
	
	init(predicate: NSPredicate, _ message: String? = nil) {
		evaluator = { (str, valid, invalid) in
			let res = predicate.evaluateWithObject(str)
			if let valid = valid where res == true {
				valid(str)
			} else if let invalid = invalid where res == false {
				invalid(str)
			}
		}
		msg = message
	}
	
	init(block: (String? -> Bool), _ message: String? = nil) {
		evaluator = { (str, valid, invalid) in
			let res = block(str)
			if let valid = valid where res == true {
				valid(str)
			} else if let invalid = invalid where res == false {
				invalid(str)
			}
		}
		msg = message
	}
	
	func message() -> String? {
		return self.msg
	}
	
	func evaluate(str: String?, _ valid: (String? -> Void)?, _ invalid: (String? -> Void)?) -> Void {
		evaluator(str, valid, invalid)
	}
	
}