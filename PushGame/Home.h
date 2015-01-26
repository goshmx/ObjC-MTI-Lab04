//
//  ViewController.h
//  PushGame
//
//  Created by TRON on 19/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface Home : UIViewController
//layers
@property (strong, nonatomic) IBOutlet UILabel *layerTimer;
@property (strong, nonatomic) IBOutlet UILabel *labelPush;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblScore;
@property (strong, nonatomic) IBOutlet UILabel *lblInstrucciones;
@property (strong, nonatomic) IBOutlet UIButton *btnInicio;
@property (strong, nonatomic) IBOutlet UILabel *lblTimer;
@property (strong, nonatomic) IBOutlet UIButton *btnPush;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleTimer;


//Actions
- (IBAction)btnPush:(id)sender;
- (IBAction)accionInicio:(id)sender;


@end

