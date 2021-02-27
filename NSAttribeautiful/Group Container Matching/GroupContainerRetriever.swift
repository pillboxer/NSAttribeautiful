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
            let containerString = try container(in: document)
            let groups = try parseGroups(from: containerString)
            let container = GroupContainer(groups: groups)
            DebugLogger.log(message: "Retrieved container with groups:\n\n\(container.description)", minimumLogLevel: .verbose)
            return container
        }
        catch let error {
            throw error
        }

    }
    
    /// Checks the document against the group container match pattern
    private static func container(in document: String) throws -> String {
        let pattern = RegexPattern.patternFor(.groupContainerMatch)
        guard let match = RegexHelper.firstMatchFor(pattern: pattern, in: document) else {
            throw NSAttribeautifulError.missingGroupContainer
        }
        return match
    }
    
    /// Retrieves a number of `Group` items that will be applied to the document
    private static func parseGroups(from container: String) throws -> [Group] {
        let pattern = RegexPattern.patternFor(.groupsMatch)
        let matches = RegexHelper.matchesFor(pattern: pattern, in: container)   
        var groups: [Group] = []
        
        for match in matches {
            let fontPattern = RegexPattern.patternFor(.fontMatch)
            let sizePattern = RegexPattern.patternFor(.sizeMatch)
            let colorPattern = RegexPattern.patternFor(.colorMatch)
            
            guard let font = RegexHelper.firstMatchFor(pattern: fontPattern, in: match),
                  let size = RegexHelper.firstMatchFor(pattern: sizePattern, in: match),
                  let color = RegexHelper.firstMatchFor(pattern: colorPattern, in: match)
            else {
                throw NSAttribeautifulError.groupMatchFailed
            }
            let newGroup = Group(font: font, size: size, color: color)
            groups.append(newGroup)
        }
        return groups
        
    }
}
