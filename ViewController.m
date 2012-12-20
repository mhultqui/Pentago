//
//  ViewController.m
//  Pentago
//
//  Created by Mike on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

@implementation ViewController

- (IBAction)newGameSelected:(id)sender{
    NSLog(@"new game");
}
- (IBAction)setMoveSelected:(id)sender{
    NSLog(@"set move");

}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blueColor]];
    [self getSize];
    [self setup];
    [self createButtons];
    //[self createBoard];
    [self resetBoard];
}
- (void)getSize{
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    if(width > height){
        CGFloat tmp = width;
        width = height;
        height = tmp;
    }
}

- (void)setup{
    int base = [self scale:830];
    int b2 = base/2;
    int side = [self scale:300];
    subIndex = 0;
    
    UIView *board1 = [[UIView alloc]initWithFrame:CGRectMake(width/2.0-side-1, b2-side-1, side, side)];
    UIView *board2 = [[UIView alloc]initWithFrame:CGRectMake(width/2.0+1, b2-side-1, side, side)];
    UIView *board3 = [[UIView alloc]initWithFrame:CGRectMake(width/2.0-side-1, b2+1, side, side)];
    UIView *board4 = [[UIView alloc]initWithFrame:CGRectMake(width/2.0+1, b2+1, side, side)];
    
    boardViews = [[NSArray alloc]initWithObjects:board1,board2,board3,board4, nil];
    rotations[0] = 0.0f;
    rotations[1] = 0.0f;
    rotations[2] = 0.0f;
    rotations[3] = 0.0f;

    subBoardArrays = [[NSArray alloc]initWithObjects:
                      [self setupSubboard:board1],
                      [self setupSubboard:board2],
                      [self setupSubboard:board3],
                      [self setupSubboard:board4], nil];
}

- (int)scale:(int)num{
    return num * height/1004.0;
}

- (NSMutableArray *) setupSubboard:(UIView *)subboard{
    CGFloat size = subboard.bounds.size.width;
    CGFloat imagesize = size/3.0;
    NSMutableArray *temp = [[NSMutableArray alloc]initWithCapacity:9];

    for(int i = 0; i<3; i++){
        for( int j = 0; j<3;j++){
            CGRect imagerect = CGRectMake(imagesize*j, imagesize*i, imagesize-1, imagesize-1);
            UIImageView *place = [[UIImageView alloc]initWithFrame:imagerect];
            if(i && j){
                place.image = [UIImage imageNamed:@"sq-bar.jpg"];
            }
            else{
                place.image = [UIImage imageNamed:@"sq-white.jpg"];
            }
            place.layer.cornerRadius = imagesize/2.0;
            [place.layer setMasksToBounds:YES];
            [place.layer setAnchorPoint:CGPointMake(0.5,0.5)];
            [subboard addSubview:place];
            [temp addObject:place];
        }
    }
    subboard.backgroundColor = [UIColor brownColor];
    [subboard.layer setAnchorPoint:CGPointMake(0.5,0.5)];
    [self.view addSubview:subboard];
    return temp;
}

- (void)createButtons{
    int h = [self scale:85];
    int w = [self scale:200];
    int y = [self scale:830];
    resetGameButton = [self newButton:width/2.0 - (w+h):y:w:h:
                            @"New Game":
                            @selector(newGameSelected:)];
    setMoveButton = [self newButton:width/2.0 + h:y:w:h:
                            @"Set Move":
                            @selector(setMoveSelected:)];
    rotateCButton = [self newButton:width/2.0 - 50 :0 :50 :50 :@"<<<":@selector(rotateCC:)];
    switchButton = [self newButton:width/2.0 :0 :50 :50 :@"..." :@selector(subSwitch:)];
    rotateCCButton = [self newButton:width/2.0 +50 :0 :50 :50 :@">>>":@selector(rotateC:)];
    

}
- (IBAction)rotateC:(id)sender{
    UIView * subboard = [boardViews objectAtIndex:subIndex];
    NSArray *places = [subBoardArrays objectAtIndex:subIndex];
    rotations[subIndex] += M_PI/12;
    [self rotateSubboard:subboard :places :rotations[subIndex]];
}
- (IBAction)rotateCC:(id)sender{
    UIView * subboard = [boardViews objectAtIndex:subIndex];
    NSArray *places = [subBoardArrays objectAtIndex:subIndex];
    rotations[subIndex] -= M_PI/12;
    [self rotateSubboard:subboard :places :rotations[subIndex]];
}
- (IBAction)subSwitch:(id)sender{
    subIndex++;
    subIndex = subIndex % 4;
}

- (void)rotateSubboard:(UIView *)subboard:(NSArray *)places:(float)largeRot{
    clockwise = CATransform3DMakeRotation(largeRot, 0, 0, 1);
    counterClock = CATransform3DMakeRotation(-largeRot, 0, 0, 1);
    
    subboard.layer.transform = clockwise;
    for(int i = 0;i<[places count];i++){
        UIImageView *im = [places objectAtIndex:i];
        im.layer.transform = counterClock;
    }
}

//768x1004 iPad dimensions
//position and size based on iPad locations, adjusts for actual size
- (UIButton *)newButton:(CGFloat)x: (CGFloat)y: (CGFloat)ww: (CGFloat)hh:
                        (NSString*)title:(SEL) select {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:select
                forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    
    button.frame = CGRectMake(x, y, ww, hh);
    [self.view addSubview:button];
    return button;
}

- (void)resetBoard{
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
