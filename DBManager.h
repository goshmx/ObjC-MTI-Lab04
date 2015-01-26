//
//  DBManager.h
//  PushGame
//
//  Created by TRON on 23/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

extern int valorInsertado;

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;

-(BOOL)createDB;
-(BOOL)saveData:(int)score fechahora:(NSString*)fechahora;
-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;
-(NSArray*) listado;
-(NSMutableArray*) listar;

@end
