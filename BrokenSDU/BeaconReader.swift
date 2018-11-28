//
//  BeaconReader.swift
//  BrokenSDU
//
//  Created by Aa on 28/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import Foundation


struct RoomDetails: Decodable{
    let alias, room, roomName, level :String;
}

class BeaconReader {
    
    var map = [String : RoomDetails]()
    
    init(){
      
        
        
        
        
        
       /* if let path = Bundle.main.path(forResource: "beacons", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, RoomDetails>, let beacons = jsonResult["beacons"] as? [String : RoomDetails] {
                    map = jsonResult;
                }
            } catch {
                // handle error
            }
        }*/
        self.map = loadJson()!
    }
    func loadJson() -> [String: RoomDetails]? {
        if let url = Bundle.main.url(forResource: "beacons", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: RoomDetails] {
                    return dictionary
                }
            } catch {
                print("Error!! Unable to parse  (beacons).json")
            }
        }
        return nil
    }
}
