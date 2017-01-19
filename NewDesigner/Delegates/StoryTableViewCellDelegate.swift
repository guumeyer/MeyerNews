//
//  StoryTableViewCellDelegate.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/18/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation


protocol StoryTableViewCellDelegate : class {
    func storyTableViewCellDidTouchUpvote(_ cell: StoryTableViewCell, sender: AnyObject)
    func storyTableViewCellDidTouchComment(_ cell: StoryTableViewCell, sender: AnyObject)
}
