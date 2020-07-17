//
//  ServiceError.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

public struct ServiceError: LocalizedError {
    
    public enum ServiceErrorCode: String {
        case undefined, unauthenticated, emptyResponse, invalidDataFormat, timeout
        case emailUnique = "EMAIL_UNIQUE"
        case emailMax = "EMAIL_MAX"
        case usernameUnique = "USERNAME_UNIQUE"
        case usernameMax = "USERNAME_MAX"
        case incorrectEmail = "INCORRECT_EMAIL"
        case incorrectPassword = "INCORRECT_PASSWORD"
        case userSuppended = "USER_SUSPENDED"
        case accountNotExist = "ACCOUNT_NOT_EXIST"
        case code_402         = "402"
        case nointerNetConnection = "NoInternetConnection"
        case somethingWrong = "Some thing went wrong"
        
    }
    
    static let undefined = ServiceError(code: .undefined, reason: "error_undefined_error".localizable)
    static let unauthenticated = ServiceError(code: .unauthenticated, reason: "error_unauthenticated".localizable)
    static let emptyResponse = ServiceError(code: .emptyResponse, reason: "error_empty_response".localizable)
    static let invalidDataFormat = ServiceError(code: .invalidDataFormat, reason: "error_invalid_data_format".localizable)
    static let timeout = ServiceError(code: .timeout, reason: "error_request_time_out".localizable)
    static let userSuppended = ServiceError(code: .userSuppended, reason: "error_block_user".localizable)
    static let noInternetConnection = ServiceError(code: .nointerNetConnection, reason: "error_network_failed".localizable)
    static let  somethingWrong = ServiceError(code: .somethingWrong, reason: "error_something_went_wrong".localizable)
    
    private(set) var code: String
    private(set) var reason: String? = nil
    private(set) var data: [String: Any]?

    init(code: ServiceErrorCode, reason: String? = nil) {
        self.code = code.rawValue
        self.reason = reason
    }
    
    init() {
        self = ServiceError.somethingWrong
    }
    
    init(code: String, reason: String? = nil, data: [String: Any]? = nil) {
        self.code = code
        self.reason = reason
        self.data = data
    }
    
    init(_ error: Error) {
         if let apiError = error as? ServiceError {
             self = apiError
         } else if let nsError = error as NSError? {
             self = ServiceError(code: "\(nsError.code)", reason: nsError.localizedDescription)
         } else {
             self = ServiceError()
         }
     }
    
    public var errorDescription: String? {
        get {
            return self.reason
        }
    }
}

// MARK: - Some Error
extension ServiceError {
    /// when application not connection to internet
    static var network: ServiceError {
        ServiceError(code: ServiceErrorCode.nointerNetConnection)
    }
    /// when have error normal or unidentifi
    static var wentWrong: ServiceError {
        ServiceError(code: ServiceErrorCode.somethingWrong)
    }
    /// when parse data from api false
    static var dataFormat: ServiceError {
        ServiceError(code: ServiceErrorCode.invalidDataFormat)
    }
    /// when object be release
    static var empty: ServiceError {
        ServiceError(code: ServiceErrorCode.emptyResponse)
    }
}

enum APIResult<T: Decodable> {
    case success(T)
    case failure(ServiceError)

    var isSuccess: Bool {
        switch self {
        case .success(_):
            return true
        case .failure(_):
            return false
        }
    }
    
    var value: T? {
        switch self {
        case .success(let result):
            return result
        case .failure(_):
            return nil
        }
    }
}
