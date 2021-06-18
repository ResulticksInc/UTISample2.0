//
//  ResulticksSDKExt.swift
//  VisionBank
//
//  Created by Sivakumar R on 21/04/20.
//  Copyright © 2020 Interakt. All rights reserved.
//

import Foundation
import REIOSSDK

extension AppDelegate {

    func initResulticksSdk() {
    
        REiosHandler.debug = true;
        REiosHandler.initSdk(withAppId: "6036e22e-4a43-40e1-ba90-b6000917dc45", notificationCategory: [], success: { status in
            print("Init with apikey success with status: \(status)")
        }) { message in
            print("Init with apikey failed with error message: \(message)")
        }
    }
    
    func didReceiveResponse(data: [String : Any]) {
        print("received notification response data from resulticks delegate: \(data)")
    }
    
    func didReceiveSmartLink(data: [String : Any]) {
        print("received smartlink data from resulticks delegate: \(data)")
    }
    
}




