//
//  SHCReversiBoardDelegate.h
//  SHCReversiGame
//
//  Created by Frankie on 12/2/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SHCReversiBoardDelegate <NSObject>
// indicates that the game state has changed
- (void) gameStateChanged;
@end
