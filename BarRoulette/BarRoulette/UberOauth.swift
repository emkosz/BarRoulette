//
//  UberOauth.swift
//  BarRoulette
//
//  Created by Emma Koszinowski on 10/14/15.
//  Copyright © 2015 Emma Koszinowski. All rights reserved.
//

import Foundation
import p2_OAuth2
import Keys

class UberOAuth {

    let oauth2: OAuth2CodeGrant
    
    init() {
        
        let settings = [
            "client_id": BarrouletteKeys().uberClientId(),
            "client_secret": BarrouletteKeys().uberClientSecret(),
            "authorize_uri": "https://login.uber.com/oauth/authorize",
            "token_uri": "https://login.uber.com/oauth/token",
            "scope": "profile",
            "redirect_uris": ["barjumper://oauth/callback"],   // don't forget to register this scheme
            "keychain": false,     // if you DON'T want keychain integration
            "title": "My Service"  // optional title to show in views
            ] as OAuth2JSON            // the "as" part may or may not be needed
        
        oauth2 = OAuth2CodeGrant(settings: settings)
        
        oauth2.onAuthorize = { parameters in
            print("Did authorize with parameters: \(parameters)")
        }
        oauth2.onFailure = { error in        // `error` is nil on cancel
            if nil != error {
                print("Authorization went wrong: \(error!.localizedDescription)")
            }
        }
    }
    
    
}


