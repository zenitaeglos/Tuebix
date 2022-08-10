//
//  ConferenceParser.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 26/3/21.
//

import Foundation


// TODO: Add day index tag


protocol EventTag {
    mutating func addField(field foundCharacter: String, name tag: String)
}

/*
EventTags struct. Here it is defined which type of xml data will be received
Depending on conference there are different tags available.
Basic, Video.
*/

// Struct for basic event.
struct BasicEventTag: EventTag, Hashable {
    var start: String = ""
    var duration: String = ""
    var room: String = ""
    var title: String = ""
    var description: String = ""
    var persons: [String] = []
    var links: [String: String] = [ : ]
    var day: String = ""
    var conferenceName: String = ""
    var year: String = ""
    var link: String = ""
    var linkKey: String = ""
    var person: String = ""


    mutating func addField(field foundCharacter: String, name tag: String) {
        switch tag {
        case "start":
            self.start = foundCharacter
        case "duration":
            self.duration = foundCharacter
        case "room":
            self.room = foundCharacter
        case "title":
            self.title += foundCharacter
        case "description":
            self.description += foundCharacter
        case "person":
            self.person += foundCharacter
        case "day":
            self.day = foundCharacter
        case "link":
            self.linkKey += foundCharacter
        case "href":
            var correctedLink = foundCharacter
            if !correctedLink.starts(with: "http") {
                correctedLink = "https://" + correctedLink
            }
            self.link = correctedLink
        case "conference":
            self.conferenceName = foundCharacter
        case "year":
            self.year = foundCharacter
        case "personCompound":
            self.persons.append(self.person)
            self.person = ""
        case "linkCompound":
            self.links[self.linkKey] = self.link
            self.linkKey = ""
            self.link = ""
        default:
            break
        }
    }
}

struct VideoEventTag: EventTag, Hashable {
    var start: String = ""
    var duration: String = ""
    var room: String = ""
    var title: String = ""
    var subtitle: String = ""
    var track: String = ""
    var abstract: String = ""
    var description: String = ""
    var persons: [String] = []
    var links: [String: String] = [ : ]
    var day: String = ""
    var conferenceName: String = ""
    var year: String = ""
    
    mutating func addField(field foundCharacter: String, name tag: String) {
        // TODO. add functionality to video event.
    }
    
    func isVideo() -> Bool {
        for (key, _) in self.links {
            if key.lowercased().replacingOccurrences(of: " ", with: "").contains("videorecording(mp4)") {
                return true
            }
        }
        return false
    }
}


protocol EventParserDelegate: AnyObject {
    func parser(didFinishBasicEventParser event: EventTag) -> Void
}

// parser for basic conferences
class BasicEventParser: NSObject {
    var event: BasicEventTag
    var delegate: EventParserDelegate?
    var currentElement: String
    
    
    init(day: String, conference: String, year: String) {
        self.event = BasicEventTag()
        self.currentElement = ""
        self.event.addField(field: conference, name: "conference")
        self.event.addField(field: year, name: "year")
        self.event.addField(field: day, name: "day")
        super.init()
    }
    
    override init() {
        self.event = BasicEventTag()
        self.currentElement = ""
        super.init()

    }
}


extension BasicEventParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentElement = elementName
        // find link if available
        for (key, value) in attributeDict {
            self.event.addField(field: value, name: key)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.event.addField(field: string, name: self.currentElement)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.event.addField(field: "", name: elementName + "Compound")

        if elementName == "event" {
            self.delegate?.parser(didFinishBasicEventParser: self.event)
        }
        self.currentElement = ""
    }
}



class VideoEventParser: NSObject {
    var event: VideoEventTag
    var delegate: EventParserDelegate?
    var currentElement: String
    
    var person: String
    var link: String
    let day: String
    let conferenceName: String
    let year: String
    
    init(day: String, conference: String, year: String) {
        self.event = VideoEventTag()
        self.currentElement = ""
        self.person = ""
        self.link = ""
        self.day = day
        self.conferenceName = conference
        self.year = year
        super.init()
    }
    
    override init() {
        self.event = VideoEventTag()
        self.currentElement = ""
        self.person = ""
        self.link = ""
        self.day = ""
        self.conferenceName = ""
        self.year = ""
        super.init()

    }
}


extension VideoEventParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentElement = elementName
        
        // find link if available
        if let link = attributeDict["href"] {
            self.link = link
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.currentElement == "start" {
            self.event.start = string
        }
        
        if self.currentElement == "duration" {
            self.event.duration = string
        }
        
        if self.currentElement == "room" {
            self.event.room = string
        }
        
        if self.currentElement == "title" {
            self.event.title = string
        }
        
        if self.currentElement == "subtitle" {
            self.event.subtitle = string
        }
        
        if self.currentElement == "description" {
            self.event.description += string
        }
        
        if self.currentElement == "person" {
            self.person += string
        }
        
        if self.currentElement == "link" {
            self.event.links[string] = self.link
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "person" {
            self.event.persons.append(self.person)
            self.person = ""
        }
        
        if elementName == "event" {
            self.event.day = self.day
            self.event.conferenceName = self.conferenceName
            self.event.year = self.year
            self.delegate?.parser(didFinishBasicEventParser: self.event)
        }
        self.currentElement = ""
        self.link = ""
    }
}



class ConferenceParser: NSObject {
    
    let parser: XMLParser
    var currentParser: XMLParserDelegate?
    var conferenceTalks: [EventTag]
    let type: String
    var day: String
    var currentTag: String
    var conference: String
    var year: String

    
    init(data: Data, type: String) {
        self.parser = XMLParser(data: data)
        self.conferenceTalks = [EventTag]()
        self.type = type
        self.day = ""
        self.currentTag = ""
        self.conference = ""
        self.year = ""
        super.init()

        self.parser.delegate = self
        self.parser.parse()
    }
    
    func allTalks() -> [EventTag] {
        return self.conferenceTalks
    }
    
    func printAll() {
        for item in self.conferenceTalks {
            print("\(item)")
        }
        print(self.conferenceTalks.count)
    }
}

extension ConferenceParser: XMLParserDelegate {

    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "day", let day = attributeDict["index"]  {
            self.day = day
        }
        
        self.currentTag = elementName
        
        if elementName == "event" {
            if self.type == "basic" {
                let basicEventParser = BasicEventParser(day: self.day, conference: self.conference, year: self.year)
                basicEventParser.delegate = self
                self.parser.delegate = basicEventParser
                self.currentParser = basicEventParser
            }
            
            else if self.type == "video" {
                let videoEventParser = VideoEventParser(day: self.day, conference: self.conference, year: self.year)
                videoEventParser.delegate = self
                self.parser.delegate = videoEventParser
                self.currentParser = videoEventParser
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.currentTag == "title" {
            self.conference += string
        }
        else if self.currentTag == "start" {
            self.year += string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentTag = ""
    }
}

extension ConferenceParser: EventParserDelegate {
    func parser(didFinishBasicEventParser event: EventTag) {
        self.parser.delegate = self
        self.currentParser = nil
        self.conferenceTalks.append(event)
    }
    
    
}
