//
//  SHCBoardDelegate.h
//  SHCReversiGame
//
//  Created by Frankie on 12/1/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardCellState.h"

@protocol SHCBoardDelegate <NSObject>

- (void)cellStateChanged:(BoardCellState)state forColumn:(int)column andRow:(int) row;

@end
