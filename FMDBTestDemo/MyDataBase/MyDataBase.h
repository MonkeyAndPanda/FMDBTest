//
//  MyDataBase.h
//  KoalaKnow
//
//  Created by 曹杰 on 16/2/2.
//  Copyright © 2016年 szjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People.h"
#import "FMDB.h"


@interface MyDataBase : NSObject
//建立单例对象
+(MyDataBase *)shareFMDataBase;

-(void)qunueCreatPeopleTable;
-(void)qunueInsertPeople:(People *)people;
-(NSArray *)qunueGetPeople;
-(void)qunueDeleteAllPeople;

@end
