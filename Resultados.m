//
//  Resultados.m
//  PushGame
//
//  Created by TRON on 21/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "Resultados.h"
#import "ScoresList.h"

NSMutableArray *datos;
NSTimer *myTimer;
int contador;
int pos;
int total;

@interface Resultados ()

@end

@implementation Resultados

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)accionRegresar:(id)sender {
    [self performSegueWithIdentifier:@"sagaVolver" sender:self];
}

- (void)animaList{
    int lastRowNumber = (int)[self.tblMain numberOfRowsInSection:0] - (total-pos);
    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
    [self.tblMain scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //UITableViewCell *celda = [self.tblMain cellForRowAtIndexPath:ip];
    //celda.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:95.0/255.0 blue:22.0/255.0 alpha:1.0];
    [myTimer invalidate];
    myTimer = nil;
}

- (void)initController{
    contador = 0;
    datos = [[DBManager getSharedInstance]listar];
    NSLog(@"Valor insertado: %d",valorInsertado);
    //NSLog(@"%@", datos);
    
    for(NSArray *st in datos) {
        NSLog(@"%@",st);
        if([[st objectAtIndex:0] integerValue] == valorInsertado){
            pos = contador;
        }
        contador++;
    }
    total = (int)[datos count];
    
    NSLog(@"Valor posicion: %d",pos);
    
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tblMain scrollToRowAtIndexPath:indexPath
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(animaList) userInfo:nil repeats:NO];
    
    }


/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    total = (int)[datos count];
    return [datos count];
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScoresList";
    ScoresList *cell = (ScoresList *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[ScoresList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray *dato = datos[indexPath.row];
    contador++;
    cell.score.text = [dato objectAtIndex:0];
    cell.fechahora.text = [dato objectAtIndex:1];
    return cell;
}

//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
