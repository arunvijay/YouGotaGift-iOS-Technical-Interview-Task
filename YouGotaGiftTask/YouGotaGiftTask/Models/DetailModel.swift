//
//  DetailModel.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 14/01/21.
//

import Foundation

// MARK: - CardDetails
struct CardDetails: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let isGeneric: Bool?
    let productImage: String?
    let seoName, currency: String?
    let country: Country?
    let validityInMonths: Int?
    let variableAmount: Bool?
    let denominations: [[String: Denomination]]?
    let redemptionNote: String?
    let location: Bool?
    let locationDetails: LocationDetails?
    let tagline, shortTagline, specificTerms, cardDetailsDescription: String?
    let reviews: Bool?
    let reviewURL: String?
    let requireMobileVerification, buyForYourself: Bool?
    let verificationDetails: VerificationDetails?
    let redemptionTag: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, logo
        case isGeneric = "is_generic"
        case productImage = "product_image"
        case seoName = "seo_name"
        case currency, country
        case validityInMonths = "validity_in_months"
        case variableAmount = "variable_amount"
        case denominations
        case redemptionNote = "redemption_note"
        case location
        case locationDetails = "location_details"
        case tagline
        case shortTagline = "short_tagline"
        case specificTerms = "specific_terms"
        case cardDetailsDescription = "description"
        case reviews
        case reviewURL = "review_url"
        case requireMobileVerification = "require_mobile_verification"
        case buyForYourself = "buy_for_yourself"
        case verificationDetails = "verification_details"
        case redemptionTag = "redemption_tag"
    }
}

// MARK: - Country
struct Country: Codable {
    let name, code: String?
}

// MARK: - Denomination
struct Denomination: Codable {
    let step, min, max: Int?
}

// MARK: - LocationDetails
struct LocationDetails: Codable {
    let locationDescription, locationLabel: String?
    let locationBlocks: [LocationBlock]?

    enum CodingKeys: String, CodingKey {
        case locationDescription = "location_description"
        case locationLabel = "location_label"
        case locationBlocks = "location_blocks"
    }
}

// MARK: - LocationBlock
struct LocationBlock: Codable {
    let title, locationBlockDescription: String?
    let locations: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case locationBlockDescription = "description"
        case locations
    }
}

// MARK: - VerificationDetails
struct VerificationDetails: Codable {
    let anyCountry: Bool?
    let mobileRegex: String?

    enum CodingKeys: String, CodingKey {
        case anyCountry = "any_country"
        case mobileRegex = "mobile_regex"
    }
}
