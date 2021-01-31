//
//  GroupContainerRetriever.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

class GroupContainerRetriever {
    
    /// - Parameters:
    ///   - document: The `String` containing the `document` text.
    /// - throws: An `NSAttribeautifulError` if `document` does not contain a valid `GroupContainer` at the beginning of the document
    static func groupContainerFor(_ document: String) throws -> GroupContainer {
        do {

        }
        catch let error as NSAttribeautifulError {
            DebugLogger.log(message: error.errorDescription)
            throw error
        }
        // FIXME: -
        return GroupContainer(groups: [])
    }
    
    /// Checks the document against the group container match pattern
    private static func container(in document: String) throws -> String {
        let pattern = RegexPattern.patternFor(.groupContainerMatch)
        guard let match = RegexHelper.firstMatchFor(pattern: pattern, in: document) else {
            throw NSAttribeautifulError.missingGroupContainer
        }
        return match
    }
    
    private static func parseGroups(from container: String) throws -> GroupContainer {
        let pattern = RegexPattern.patternFor(.groupsMatch)
        return GroupContainer(groups: [])
    }
}



























//    /// Find each of the groups in the group list -> [m:15:r], [qsb:12:g] etc...
//    let parameterGroupPattern = try! NSRegularExpression(pattern: #"\[\w+:\d+:\w+\]"#)
//    let groupMatches = parameterGroupPattern.matches(in: parameterGroupListString, options: [], range: parameterGroupListString.wholeRange())
//
//    for groupMatch in groupMatches {
//
//        let fontPattern = try! NSRegularExpression(pattern: #"(?<=\[)\w+"#)
//        let sizePattern = try! NSRegularExpression(pattern: #"(?<=\:)\d+"#)
//        let colorPattern = try! NSRegularExpression(pattern: #"\w+(?=\])"#)
//
//        if let groupRange = Range(groupMatch.range, in: parameterGroupListString) {
//
//            let singleGroupString = String(parameterGroupListString[groupRange])
//
//            guard let fontMatch = fontPattern.firstMatch(in: singleGroupString, options: [], range: singleGroupString.wholeRange()),
//                  let sizeMatch = sizePattern.firstMatch(in: singleGroupString, options: [], range: singleGroupString.wholeRange()),
//                  let colorMatch = colorPattern.firstMatch(in: singleGroupString, options: [], range: singleGroupString.wholeRange()),
//                  let fontRange = Range(fontMatch.range, in: singleGroupString),
//                  let sizeRange = Range(sizeMatch.range, in: singleGroupString),
//                  let colorRange = Range(colorMatch.range, in: singleGroupString) else {
//                printError(.couldNotRetrieve("Font, size or color missing from \(singleGroupString)"))
//                return nil
//            }
//            let data = Data(contentsOf: "")
//            let fontString = String(singleGroupString[fontRange])
//            let sizeString = String(singleGroupString[sizeRange])
//            let colorString = String(singleGroupString[colorRange])
//
//            let newGroup = ParameterGroup(font: fontString, size: sizeString, color: colorString)
//            parameterGroups.append(newGroup)
//
//        }
//
//        else {
//            printError(.couldNotRetrieve("Group Range Does Not Exist"))
//        }
//    }
//    return parameterGroups
//}
//
//
