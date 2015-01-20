//
//  ViewController.h
//  PushGame
//
//  Created by TRON on 19/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home : UIViewController

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblScore;

//Actions
- (IBAction)btnPush:(id)sender;

@end

