//
//  MyDataBase.m
//  KoalaKnow
//
//  Created by 曹杰 on 16/2/2.
//  Copyright © 2016年 szjn. All rights reserved.
//

#import "MyDataBase.h"

@interface MyDataBase ()
{
  //声明一个数据库对象（用于操作数据库）
  FMDatabase *_dataBase;
  FMDatabaseQueue *_queue;
}
@end

@implementation MyDataBase
+(MyDataBase *)shareFMDataBase{
  static MyDataBase *mDB = nil;
  if (mDB == nil) {
    mDB = [[super alloc]init];
    [mDB myQueue];
  }
  
  
  return mDB;
}

-(void)myQueue{
  NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString* filePath = [docsdir stringByAppendingPathComponent:@"FMDBTestDemo.sqlite"];
  _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
  NSLog(@"filePath:%@",filePath);
  
}

-(void)qunueCreatPeopleTable{
  
  NSString *creatTableString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS People(people_name text, age text, pets blob, car blob)"];
  
  
  
  [_queue inDatabase:^(FMDatabase *db) {
    
    BOOL b = [db executeUpdate:creatTableString];
    
    NSLog(@"create table is %d",b);
    
  }];
  

  
}
-(void)qunueInsertPeople:(People *)people{
  
  
  //pets转化data
  NSData *petsData = [NSKeyedArchiver archivedDataWithRootObject:people.pets];
  //car转换data
  NSData *carData = [NSKeyedArchiver archivedDataWithRootObject:people.car];
  
  [_queue inDatabase:^(FMDatabase *db) {
    
    BOOL insert = [db executeUpdate:@"INSERT INTO People (people_name, age, pets, car) VALUES (?,?,?,?)",people.name,people.age,petsData,carData];
    
    if (insert) {
      NSLog(@"添加成员成功！！");
    }else{
      NSLog(@"添加成员失败！！");
    }
    
  }];

}
-(NSArray *)qunueGetPeople{
  __block NSMutableArray *dataArray = nil;


  NSString *sql = [NSString stringWithFormat:@"SELECT *FROM People"];
  
  [_queue inDatabase:^(FMDatabase *db) {
    dataArray = [NSMutableArray array];
    FMResultSet *result = [db executeQuery:sql];
    while ([result next]) {
      //从表单中获取相应字段的value
      
      People *people = [People new];
      people.name = [result stringForColumn:@"people_name"];
      people.age = [result stringForColumn:@"age"];
      //pets
      NSData *petData = [result dataForColumn:@"pets"];
      NSArray * arr  = [NSKeyedUnarchiver unarchiveObjectWithData:petData];
      //car
      NSData *carData = [result dataForColumn:@"car"];
      Car *car = [NSKeyedUnarchiver unarchiveObjectWithData:carData];
      
      people.car = car;
      people.pets = arr;
      
      [dataArray addObject:people];
    }
    
  }];
  
  
  return dataArray;
  
}
-(void)qunueDeleteAllPeople{

  NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM People"];
  [_queue inDatabase:^(FMDatabase *db) {
    
    if (![db executeUpdate:sqlstr])
    {
      NSLog(@"Erase table 失败!");
      
    }else{
      NSLog(@"Erase table 成功!");
    }
    
  }];
  
  
  

}

@end
