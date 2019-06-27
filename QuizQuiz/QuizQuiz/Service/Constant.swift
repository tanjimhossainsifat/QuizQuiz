//
//  Constant.swift
//  QuizQuiz
//
//  Created by Tanjim Hossain Sifat on 27/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit

import UIKit

class Constant {
    
    private static let baseUrl: String = "http://quizone.redgreen.studio/quizone/public/api/category/1/questions"
    private static let imageBaseUrl: String = "http://quizone.redgreen.studio/quizone/public/uploads/question/"
    
    static func getBaseUrl() -> String {
        return baseUrl
    }
    
    static func getImageBaseUrl() -> String {
        return imageBaseUrl
    }
    
    static func getApiUrl() -> String {
        return getBaseUrl()
    }
}

