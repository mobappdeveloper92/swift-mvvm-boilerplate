//
//  DateFormat.swift
//  Ecommerce
//
//  Created by Faizan Mahmood on 01/06/2022.
//

import Foundation

public enum DateFormat: String {
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case hhmmaSepddMMMMyyyy = "hh:mm a | dd MMMM yyyy"
    case ddMMMMyyyySephhmma = "dd MMMM yyyy | hh:mm a"
    case ddMMMMyyyy = "dd / MMMM / yyyy"
    case ddMMMMyyyyWithoutSep = "dd MMMM yyyy"
    case ddMMMyyyy = "dd MMM yyyy"
    case yyyyMMdd = "yyyy-MM-dd"
    case HHmm = "HH:mm"
}
