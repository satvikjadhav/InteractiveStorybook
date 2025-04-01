//
//  StoryPage.swift
//  InteractiveStorybook
//
//  Created by Satvik  Jadhav on 4/1/25.
//

struct StoryPage {
    let id: Int
    let backgroundImage: String
    let characterImage: String
    let text: String
}

let storyPages = [
    StoryPage(id: 1, backgroundImage: "background1", characterImage: "character1", text: "Once upon a time..."),
    StoryPage(id: 2, backgroundImage: "background2", characterImage: "character2", text: "A brave knight set out..."),
    StoryPage(id: 3, backgroundImage: "background3", characterImage: "character3", text: "And saved the kingdom!")
]
