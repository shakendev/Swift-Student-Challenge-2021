/*
 *
 *    Xcode Playground Project
 *
 *    - - - - - - - - - -
 *
 *    Developed specifically & only for WWDC21
 *
 *    - - - - - - - - - -
 *
 *    Name: Leap Boy
 *
 *    Genre: 2D platformer specially built for WWDC21
 *
 *    Game Design: Specially created design for WWDC21
 *
 *    Environment: 2D Screen Space
 *
 *    Target Platform: Xcode Playground
 *
 *    User Experience: You can always think that everything is good [🙂], when in fact everything is bad [☹️].
 *
 *    Game Description:
 *        You play as a little man,
 *        for whom you need to collect a certain number of coins in the current level to access the next level
 *        (in this case, a couple of levels have been created in order to keep within 3 minutes of gameplay)
 *
 *    Game Goal: Collect coins by unlocking subsequent levels
 *
 *    Game Credits:
 *        ./Sources/ - All the code is invented and implemented independently
 *        ./Resources/Images/ - All icons and images are drawn using applications such as: Sketch & Pixelmator
 *        ./Resources/SFX/Music - All musical compositions are written using applications such as: GarageBand & Logic Pro
 *        ./Resources/Sounds/ - Used sounds from open source at: https://opengameart.org
 *        ./Resources/VFX/ - All VFXs were implemented and tested in the Xcode project, and then transferred to the playground
 *
 *    - - - - - - - - - -
 *
 *    Author:
 *        Created by Dimka Novikov on 04.04.2021
 *        Copyright © 2021 //DDEC. All Rights Not Reserved.     :)
 *
 *    - - - - - - - - - -
 *
 *    Country: Russia
 *    Hometown: Yuzhno-Sakhalinsk     😎
 *
 *    University:
 *        Location: St. Petersburg     🤓
 *        Information:
 *            let universityName = (key: "itmo",
 *                                  name: "ITMO University",
 *                                  description: "🤡")
 *            let studyDirection = (key: "GameDev",
 *                                  name: "Computer game development technologies",
 *                                  description: "🎮")
 *
 *    - - - - - - - - - -
 *
 *    Software & Hardware, which were used for testing:
 *
 *    + - - - - - + - - - + - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - +
 *    |     Model |       |  MacBook Air 13" 2017       |  MacBook Pro 13" 2019 (Two TB Ports)  |
 *    + - - - - - + - - - + - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - +
 *    |  Software |   OS: |  macOS Big Sur 11.1         |  macOS Big Sur 11.2.3                 |
 *    |           |  IDE: |  Xcode 12.4                 |  Xcode 12.4                           |
 *    + - - - - - + - - - + - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - +
 *    |  Hardware |  CPU: |  Intel Core i7              |  Intel Core i7                        |
 *    |           |  RAM: |  8 GB LPDDR3                |  16 GB LPDDR3                         |
 *    |           |  GPU: |  0: Intel HD Graphics 6000  |  0: Intel Iris Plus Graphics 645      |
 *    |           |       |                             |  1: AMD Radeon RX 580                 |
 *    + - - - - - + - - - + - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - - - - +
 *
 */




// MARK: - Import section

// Importing a PlaygroundSupport framework
import PlaygroundSupport




// MARK: - UIViewController live preview

// Create live preview for InitialViewController
PlaygroundPage.current.liveView = InitialViewController()
