//
//  CommentTableViewCellDelegate.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/19/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation

protocol CommentTableViewCellDelegate: class {
    func commentTableViewCellDidTouchUpvote(_ cell: CommentsTableViewCell)
    func commentTableViewCellDidTouchComment(_ cell: CommentsTableViewCell)
}
