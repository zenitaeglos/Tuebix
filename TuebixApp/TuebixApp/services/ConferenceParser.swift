//
//  ConferenceParser.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 26/3/21.
//

import Foundation




protocol EventTag {
    
}

/*
EventTags struct. Here it is defined which type of xml data will be received
Depending on conference there are different tags available.
Basic, Video.
*/

// Struct for basic event.
struct BasicEventTag: EventTag {
    var start: String = ""
    var duration: String = ""
    var room: String = ""
    var title: String = ""
    var description: String = ""
    var persons: [String] = []
    var links: [String: String] = [ : ]
}

struct VideoEventTag: EventTag {
    var room: String = ""
}


protocol EventParserDelegate: AnyObject {
    func parser(didFinishBasicEventParser event: EventTag) -> Void
}

// parser for basic conferences
class BasicEventParser: NSObject {
    var event: BasicEventTag
    var delegate: EventParserDelegate?
    var currentElement: String
    
    var person: String
    var link: String
    
    override init() {
        self.event = BasicEventTag()
        self.currentElement = ""
        self.person = ""
        self.link = ""
        super.init()

    }
}


extension BasicEventParser: XMLParserDelegate {
    
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
        
        if self.currentElement == "description" {
            self.event.description = string
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
            self.delegate?.parser(didFinishBasicEventParser: self.event)
        }
        
        self.currentElement = ""
        self.link = ""
    }
}



class VideoEventParser: NSObject {
    var event: VideoEventTag
    var delegate: EventParserDelegate?
    var currentElement: String
    
    override init() {
        self.event = VideoEventTag()
        self.currentElement = ""
        super.init()

    }
}


extension VideoEventParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.currentElement == "room" {
            self.event.room = string
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "event" {
            self.delegate?.parser(didFinishBasicEventParser: self.event)
        }
        self.currentElement = ""
    }
}



class ConferenceParser: NSObject {
    
    let parser: XMLParser
    var currentParser: XMLParserDelegate?
    var conferenceTalks: [EventTag]
    let type: String

    
    init(data: Data, type: String) {
        self.parser = XMLParser(data: data)
        self.conferenceTalks = [EventTag]()
        self.type = type
        super.init()

        self.parser.delegate = self
        self.parser.parse()
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
        
        if elementName == "event" {
            if self.type == "basic" {
                let basicEventParser = BasicEventParser()
                basicEventParser.delegate = self
                self.parser.delegate = basicEventParser
                self.currentParser = basicEventParser
            }
            
            else if self.type == "video" {
                let videoEventParser = VideoEventParser()
                videoEventParser.delegate = self
                self.parser.delegate = videoEventParser
                self.currentParser = videoEventParser
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //print("\(string)")
    }
}

extension ConferenceParser: EventParserDelegate {
    func parser(didFinishBasicEventParser event: EventTag) {
        self.parser.delegate = self
        self.currentParser = nil
        self.conferenceTalks.append(event)
    }
    
    
}
