//
//  ViewController.h
//  Pentago
//
//  Created by Mike on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController{
    UIButton *resetGameButton;
    UIButton *setMoveButton;
    NSArray *boardViews;
    NSArray *subBoardArrays;
    
    CGFloat height;
    CGFloat width;
}

@end
