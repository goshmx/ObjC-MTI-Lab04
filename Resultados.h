//
//  Resultados.h
//  PushGame
//
//  Created by TRON on 21/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface Resultados : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

- (IBAction)accionRegresar:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblMain;

@end
