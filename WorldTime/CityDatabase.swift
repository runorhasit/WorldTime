//
//  CityDatabase.swift
//  WorldTime
//
//  Created by Runor Jiroma on 23/01/2026.
//

import Foundation

struct CityDatabase {
    static let cities: [CityTime] = [
        // Africa
        CityTime(city: "Abidjan", timeZoneIdentifier: "Africa/Abidjan"),
        CityTime(city: "Accra", timeZoneIdentifier: "Africa/Accra"),
        CityTime(city: "Addis Ababa", timeZoneIdentifier: "Africa/Addis_Ababa"),
        CityTime(city: "Cairo", timeZoneIdentifier: "Africa/Cairo"),
        CityTime(city: "Cape Town", timeZoneIdentifier: "Africa/Johannesburg"),
        CityTime(city: "Casablanca", timeZoneIdentifier: "Africa/Casablanca"),
        CityTime(city: "Johannesburg", timeZoneIdentifier: "Africa/Johannesburg"),
        CityTime(city: "Lagos", timeZoneIdentifier: "Africa/Lagos"),
        CityTime(city: "Nairobi", timeZoneIdentifier: "Africa/Nairobi"),
        
        // Americas
        CityTime(city: "Anchorage", timeZoneIdentifier: "America/Anchorage"),
        CityTime(city: "Atlanta", timeZoneIdentifier: "America/New_York"),
        CityTime(city: "Austin", timeZoneIdentifier: "America/Chicago"),
        CityTime(city: "Bogota", timeZoneIdentifier: "America/Bogota"),
        CityTime(city: "Boston", timeZoneIdentifier: "America/New_York"),
        CityTime(city: "Buenos Aires", timeZoneIdentifier: "America/Argentina/Buenos_Aires"),
        CityTime(city: "Chicago", timeZoneIdentifier: "America/Chicago"),
        CityTime(city: "Dallas", timeZoneIdentifier: "America/Chicago"),
        CityTime(city: "Denver", timeZoneIdentifier: "America/Denver"),
        CityTime(city: "Detroit", timeZoneIdentifier: "America/Detroit"),
        CityTime(city: "Honolulu", timeZoneIdentifier: "Pacific/Honolulu"),
        CityTime(city: "Houston", timeZoneIdentifier: "America/Chicago"),
        CityTime(city: "Lima", timeZoneIdentifier: "America/Lima"),
        CityTime(city: "Los Angeles", timeZoneIdentifier: "America/Los_Angeles"),
        CityTime(city: "Mexico City", timeZoneIdentifier: "America/Mexico_City"),
        CityTime(city: "Miami", timeZoneIdentifier: "America/New_York"),
        CityTime(city: "Montreal", timeZoneIdentifier: "America/Toronto"),
        CityTime(city: "New York", timeZoneIdentifier: "America/New_York"),
        CityTime(city: "Phoenix", timeZoneIdentifier: "America/Phoenix"),
        CityTime(city: "San Francisco", timeZoneIdentifier: "America/Los_Angeles"),
        CityTime(city: "Santiago", timeZoneIdentifier: "America/Santiago"),
        CityTime(city: "Sao Paulo", timeZoneIdentifier: "America/Sao_Paulo"),
        CityTime(city: "Seattle", timeZoneIdentifier: "America/Los_Angeles"),
        CityTime(city: "Toronto", timeZoneIdentifier: "America/Toronto"),
        CityTime(city: "Vancouver", timeZoneIdentifier: "America/Vancouver"),
        CityTime(city: "Washington DC", timeZoneIdentifier: "America/New_York"),
        
        // Asia
        CityTime(city: "Baghdad", timeZoneIdentifier: "Asia/Baghdad"),
        CityTime(city: "Bangkok", timeZoneIdentifier: "Asia/Bangkok"),
        CityTime(city: "Beijing", timeZoneIdentifier: "Asia/Shanghai"),
        CityTime(city: "Dhaka", timeZoneIdentifier: "Asia/Dhaka"),
        CityTime(city: "Dubai", timeZoneIdentifier: "Asia/Dubai"),
        CityTime(city: "Abu Dhabi", timeZoneIdentifier: "Asia/Dubai"),
        CityTime(city: "Hong Kong", timeZoneIdentifier: "Asia/Hong_Kong"),
        CityTime(city: "Jakarta", timeZoneIdentifier: "Asia/Jakarta"),
        CityTime(city: "Jerusalem", timeZoneIdentifier: "Asia/Jerusalem"),
        CityTime(city: "Karachi", timeZoneIdentifier: "Asia/Karachi"),
        CityTime(city: "Kolkata", timeZoneIdentifier: "Asia/Kolkata"),
        CityTime(city: "Kuala Lumpur", timeZoneIdentifier: "Asia/Kuala_Lumpur"),
        CityTime(city: "Manila", timeZoneIdentifier: "Asia/Manila"),
        CityTime(city: "Mumbai", timeZoneIdentifier: "Asia/Kolkata"),
        CityTime(city: "New Delhi", timeZoneIdentifier: "Asia/Kolkata"),
        CityTime(city: "Osaka", timeZoneIdentifier: "Asia/Tokyo"),
        CityTime(city: "Riyadh", timeZoneIdentifier: "Asia/Riyadh"),
        CityTime(city: "Seoul", timeZoneIdentifier: "Asia/Seoul"),
        CityTime(city: "Shanghai", timeZoneIdentifier: "Asia/Shanghai"),
        CityTime(city: "Singapore", timeZoneIdentifier: "Asia/Singapore"),
        CityTime(city: "Taipei", timeZoneIdentifier: "Asia/Taipei"),
        CityTime(city: "Tehran", timeZoneIdentifier: "Asia/Tehran"),
        CityTime(city: "Tel Aviv", timeZoneIdentifier: "Asia/Jerusalem"),
        CityTime(city: "Tokyo", timeZoneIdentifier: "Asia/Tokyo"),
        
        // Australia & Pacific
        CityTime(city: "Auckland", timeZoneIdentifier: "Pacific/Auckland"),
        CityTime(city: "Brisbane", timeZoneIdentifier: "Australia/Brisbane"),
        CityTime(city: "Melbourne", timeZoneIdentifier: "Australia/Melbourne"),
        CityTime(city: "Perth", timeZoneIdentifier: "Australia/Perth"),
        CityTime(city: "Sydney", timeZoneIdentifier: "Australia/Sydney"),
        
        // Europe
        CityTime(city: "Amsterdam", timeZoneIdentifier: "Europe/Amsterdam"),
        CityTime(city: "Athens", timeZoneIdentifier: "Europe/Athens"),
        CityTime(city: "Barcelona", timeZoneIdentifier: "Europe/Madrid"),
        CityTime(city: "Berlin", timeZoneIdentifier: "Europe/Berlin"),
        CityTime(city: "Brussels", timeZoneIdentifier: "Europe/Brussels"),
        CityTime(city: "Budapest", timeZoneIdentifier: "Europe/Budapest"),
        CityTime(city: "Copenhagen", timeZoneIdentifier: "Europe/Copenhagen"),
        CityTime(city: "Dublin", timeZoneIdentifier: "Europe/Dublin"),
        CityTime(city: "Edinburgh", timeZoneIdentifier: "Europe/London"),
        CityTime(city: "Frankfurt", timeZoneIdentifier: "Europe/Berlin"),
        CityTime(city: "Geneva", timeZoneIdentifier: "Europe/Zurich"),
        CityTime(city: "Helsinki", timeZoneIdentifier: "Europe/Helsinki"),
        CityTime(city: "Istanbul", timeZoneIdentifier: "Europe/Istanbul"),
        CityTime(city: "Lisbon", timeZoneIdentifier: "Europe/Lisbon"),
        CityTime(city: "London", timeZoneIdentifier: "Europe/London"),
        CityTime(city: "Madrid", timeZoneIdentifier: "Europe/Madrid"),
        CityTime(city: "Manchester", timeZoneIdentifier: "Europe/London"),
        CityTime(city: "Milan", timeZoneIdentifier: "Europe/Rome"),
        CityTime(city: "Moscow", timeZoneIdentifier: "Europe/Moscow"),
        CityTime(city: "Munich", timeZoneIdentifier: "Europe/Berlin"),
        CityTime(city: "Oslo", timeZoneIdentifier: "Europe/Oslo"),
        CityTime(city: "Paris", timeZoneIdentifier: "Europe/Paris"),
        CityTime(city: "Prague", timeZoneIdentifier: "Europe/Prague"),
        CityTime(city: "Rome", timeZoneIdentifier: "Europe/Rome"),
        CityTime(city: "Stockholm", timeZoneIdentifier: "Europe/Stockholm"),
        CityTime(city: "Vienna", timeZoneIdentifier: "Europe/Vienna"),
        CityTime(city: "Warsaw", timeZoneIdentifier: "Europe/Warsaw"),
        CityTime(city: "Zurich", timeZoneIdentifier: "Europe/Zurich")
    ]
    
    
}
