//
//  ViewController.m
//  FMDBTestDemo
//
//  Created by 曹小猿 on 16/8/22.
//  Copyright © 2016年 曹小猿. All rights reserved.
//

#import "ViewController.h"
#import "MyDataBase.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initControll];
  
  
}

- (void)initControll{


    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(0, 100, 100, 30);
    [btn1 setTitle:@"保存" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor yellowColor];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn1 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(0, 200, 100, 30);
    [btn2 setTitle:@"查询" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.frame = CGRectMake(0, 300, 100, 30);
    [btn3 setTitle:@"删除" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
    UIButton * btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn4.frame = CGRectMake(0, 400, 100, 30);
    [btn4 setTitle:@"更新" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    
  
}

-(void)save{
  People * people = [[People alloc]init];
  people.name = @"james";
  people.age = @"10";
  Pet * dog = [[Pet alloc]init];
  dog.name = @"dog";
  dog.age = @"1";
  Pet * cat = [[Pet alloc]init];
  cat.name = @"cat";
  cat.age = @"2";
  people.pets = @[dog,cat];
  Car * car = [[Car alloc]init];
  car.name = @"cvivi";
  car.age = @"3";
  people.car = car;
    MyDataBase * dataBase = [MyDataBase shareFMDataBase];
  [dataBase qunueCreatPeopleTable];
  [dataBase qunueInsertPeople:people];
  
  

}
-(void)check{
  MyDataBase * dataBase = [MyDataBase shareFMDataBase];
  NSArray * arr = [dataBase qunueGetPeople];
  if (arr.count) {
    for (People * p in arr) {
      People * p = (People *)[arr firstObject];
      NSLog(@"name:%@,age:%@,car:%@,car age:%@",p.name,p.age,p.car.name,p.car.age);
      for (Pet * pet in p.pets) {
        NSLog(@"pet name:%@,pet age:%@",pet.name,pet.age);
        
      }
    }
    
  }else{
    NSLog(@"空");

  }
    UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@object",[NSNumber numberWithInteger:arr.count]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [aler show];
  
  
}
-(void)delete{
  MyDataBase * dataBase = [MyDataBase shareFMDataBase];
  [dataBase qunueDeleteAllPeople];
  
}
-(void)change{
  
}

@end
