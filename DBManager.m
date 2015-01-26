//
//  DBManager.m
//  PushGame
//
//  Created by TRON on 23/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "DBManager.h"


static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager
+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"gamepush2.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "create table if not exists pushresults (pushid integer primary key AUTOINCREMENT, score integer, fechahora text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Error al crear la tabla");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Error al abrir/crear la base de datos");
        }
    }
    return isSuccess;
}



- (BOOL) saveData:(int)score fechahora:(NSString*)fechahora;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into pushresults (score,fechahora) values (\"%d\",\"%@\" )",score, fechahora];
       
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_reset(statement);
            NSLog(@"Statement SUCCESS");
            return YES;            
        } else {
            NSLog(@"Statement FAILED (%s)", sqlite3_errmsg(database));
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}


- (NSArray*) listado{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select score, fechahora from pushresults"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *score = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 0)];
                [resultArray addObject:score];
                NSString *fechahora = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:fechahora];
                sqlite3_reset(statement);
                return resultArray;
            } else {
                NSLog(@"Not found");
                sqlite3_reset(statement);
                return nil;
            }
        }
    }
    return nil;
}


- (NSMutableArray*) listar{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select score, fechahora from pushresults order by score DESC"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *ar_result = [[NSMutableArray alloc] initWithCapacity:10];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            int columns = sqlite3_column_count(statement);
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableArray *arc = [[NSMutableArray alloc] initWithCapacity:columns];
                for(int i=0; i < columns; i++){
                    if (sqlite3_column_text(statement, i) == NULL)
                        [arc addObject:@""];
                    else
                        [arc addObject:[NSString stringWithCString:(char *)sqlite3_column_text(statement, i)
                                                          encoding:NSUTF8StringEncoding]
                         ];
                }
                [ar_result addObject:arc];
            }
            sqlite3_reset(statement);
            return ar_result;

        }
    }
    return nil;
}
    
@end
