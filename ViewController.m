//
//  ViewController.m
//  Pentago
//
//  Created by Mike on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (IBAction)newGameSelected:(id)sender{
    NSLog(@"new game");
}
- (IBAction)setMoveSelected:(id)sender{
    NSLog(@"set move");

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor blueColor]];
    [self getSize];
    [self createButtons];
    [self createBoard];
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

- (void)createButtons{
    resetGameButton = [self newButton:145:830:200:85:
                            @"New Game":
                            @selector(newGameSelected:)];
    setMoveButton = [self newButton:425:830:200:85:
                            @"Set Move":
                            @selector(setMoveSelected:)];
}

//768x1004 iPad dimensions
//position and size based on iPad locations, adjusts for actual size
- (UIButton *)newButton:(CGFloat)x: (CGFloat)y: (CGFloat)ww: (CGFloat)hh:
                        (NSString*)title:(SEL) select {
    x = (x * width) / 768;   ww = (ww * width) / 768;
    y = (y * height) / 1004; hh = (hh * height) / 1004;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:select
                forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(x, y, ww, hh);
    [self.view addSubview:button];
    return button;
}
- (void)createBoard{
    
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
