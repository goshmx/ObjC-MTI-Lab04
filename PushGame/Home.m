//
//  ViewController.m
//  PushGame
//
//  Created by TRON on 19/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "Home.h"

int counter = 0;
int counterSec = 3;
NSTimer *myTimer;
int valorInsertado;



@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.    
    
    self.labelPush.layer.masksToBounds = YES;
    self.labelPush.layer.cornerRadius = 90;
    self.layerTimer.layer.masksToBounds = YES;
    self.layerTimer.layer.cornerRadius = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushAction{
    counterSec--;
    self.lblTimer.text = [[NSNumber numberWithInt:counterSec] stringValue];
    if(counterSec == 0){
        [myTimer invalidate];
        myTimer = nil;
        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSLog(@"Fecha y hora del juego: %@",[DateFormatter stringFromDate:[NSDate date]]);
        NSString *fecha = [DateFormatter stringFromDate:[NSDate date]];
        
        //PROBANDO LIBRERIA DE INSERT       
        [[DBManager getSharedInstance]saveData:counter fechahora:fecha];
        valorInsertado = counter;
        
        counterSec = 3;
        counter = 0;
        [self performSegueWithIdentifier:@"sagaResults" sender:self];
        
    }
}

- (void)activaPush{    
    counterSec--;
    self.lblTimer.text = [[NSNumber numberWithInt:counterSec] stringValue];
    if(counterSec == 0){
        [myTimer invalidate];
        myTimer = nil;
        self.btnPush.hidden = NO;
        self.btnPush.enabled = YES;
        self.lblTitleTimer.text = @"Tiempo restante";
        counterSec = 10;
        self.lblTimer.text = @"10";
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(pushAction) userInfo:nil repeats:YES];
    }
}

- (IBAction)btnPush:(id)sender {
    counter++;
    self.lblScore.text = [NSString stringWithFormat:@"%d", counter];
    
}

- (IBAction)accionInicio:(id)sender {
    NSLog(@"Inicio del juego");
    self.lblInstrucciones.hidden = YES;
    self.btnInicio.hidden = YES;
    self.lblTimer.hidden = NO;
    
    self.lblTitleTimer.text = @"El juego inicia en";
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(activaPush) userInfo:nil repeats:YES];
    
}
@end
