//
//  BoardSquare.h
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JasperAndZotBoard.h"
#import "BoardDelegate.h"

@interface BoardSquare : UIView <BoardDelegate>

- (id) initWithFrame:(CGRect)frame column:(NSInteger)column row:(NSInteger)row board:(JasperAndZotBoard*)board;

@end
