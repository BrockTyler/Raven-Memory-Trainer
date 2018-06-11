//
//  AppDelegate.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        UserDefaults.standard.set(false, forKey: "didCreateSamplePassage")
        
        let title = "The Raven"
        let text = "\"Once upon a midnight dreary, while I pondered, weak and weary, \nOver many a quaint and curious volume of forgotten lore, \nWhile I nodded, nearly napping, suddenly there came a tapping, \nAs of some one gently rapping, rapping at my chamber door. \nTis some visitor,\" I muttered, \"tapping at my chamber door — \nOnly this, and nothing more.\" \n\nAh, distinctly I remember it was in the bleak December, \nAnd each separate dying ember wrought its ghost upon the floor. \nEagerly I wished the morrow; — vainly I had sought to borrow \nFrom my books surcease of sorrow — sorrow for the lost Lenore — \nFor the rare and radiant maiden whom the angels name Lenore — \nNameless here for evermore. \n\nAnd the silken sad uncertain rustling of each purple curtain \nThrilled me — filled me with fantastic terrors never felt before; \nSo that now, to still the beating of my heart, I stood repeating, \nTis some visitor entreating entrance at my chamber door — \nSome late visitor entreating entrance at my chamber door; — \nThis it is, and nothing more.\" \n\nPresently my soul grew stronger; hesitating then no longer, \nSir,\" said I, \"or Madam, truly your forgiveness I implore; \nBut the fact is I was napping, and so gently you came rapping, \nAnd so faintly you came tapping, tapping at my chamber door, \nThat I scarce was sure I heard you\"— here I opened wide the door; — \nDarkness there, and nothing more."
        
        PassageController.createSamplePassage(title: title, text: text)
        
        return true
    }

}

