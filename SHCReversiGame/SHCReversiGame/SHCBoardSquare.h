//
//  SHCBoardSquare.h
//  SHCReversiGame
//
//  Created by Frankie on 12/1/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCReversiBoard.h"
#import "SHCBoardDelegate.h"

@interface SHCBoardSquare : UIView <SHCBoardDelegate>

- (id) initWithFrame:(CGRect)frame
              column:(NSInteger)column
                 row:(NSInteger)row
               board:(SHCReversiBoard*)board;
@end
