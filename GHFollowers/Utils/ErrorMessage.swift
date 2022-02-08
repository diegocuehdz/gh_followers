//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 07/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import Foundation

enum GFError: String, Error
{
    case errorInvalidUrl = "Invalid URL created"
    case errorUnableToComplete = "Unable to complete your request. Please check your internet connection."
    case errorInvalidResponse = "Invalid response from the server. Try Again!"
    case errorParsingData = "Parsed invalid data received from server. Try Again!"
}
