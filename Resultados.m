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
int contador;
int pos;

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

- (void)initController{
    
    datos = [[DBManager getSharedInstance]listar];
    NSLog(@"Valor insertado: %d",valorInsertado);
    //NSLog(@"%@", datos);
    //[self.tblMain scrollToRowAtIndexPath:10 atScrollPosition:UITableViewScrollPositionNone  animated:YES];
    //for (NSString *string in datos) { NSLog(@"%@", string); }
    //[self.tblMain reloadData];
    //[self.tblMain reloadData];
    
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
    //NSLog(@"ScoresList");
    
    static NSString *CellIdentifier = @"ScoresList";
    
    ScoresList *cell = (ScoresList *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ScoresList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray *dato = datos[indexPath.row];
    contador++;
    cell.score.text = [dato objectAtIndex:0];
    cell.fechahora.text = [dato objectAtIndex:1];
    if([[dato objectAtIndex:0] integerValue] == valorInsertado){
        cell.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:1 alpha:1];
        pos = contador;
    }
    return cell;
}

//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        int total = 60*pos;
        NSLog(@"Valor scroll: %d",total);
        [self.tblMain setContentOffset:CGPointMake(0, total) animated:YES];
    }
}


@end
