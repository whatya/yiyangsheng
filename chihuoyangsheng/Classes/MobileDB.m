//
//  MobileDB.m
//  SqliteTester
//
//  Created by rimi on 14-4-17.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "MobileDB.h"
#import "ABSQLiteDB.h"
#import "BaseFoodBaseFoodServiceImplServiceSoapBinding.h"
#import "AllDicsDictTypeServiceImplServiceSoapBinding.h"
#import "DicDictServiceImplServiceSoapBinding.h"
#import "AllDicsdictType.h"
#import "AreaAreaServiceImplServiceSoapBinding.h"

static MobileDB* _dbInstance;

@interface MobileDB ()
@property (nonatomic,strong)id <ABDatabase> db;
@end

@implementation MobileDB

#pragma mark - 数据库初始化

- (id) init
{
	return [self initWithFile: NULL];
}

#pragma mark - 根据名称创建数据库
- (id) initWithFile: (NSString*) filePathName {
	if (!(self = [super init])) return nil;
	
	_dbInstance = self;
	
	BOOL myPathIsDir;
	BOOL fileExists = [[NSFileManager defaultManager]
                       fileExistsAtPath: filePathName
                       isDirectory: &myPathIsDir];
	
	// backupDbPath allows for a pre-made database to be in the app. Good for testing
	NSString *backupDbPath = [[NSBundle mainBundle]
                              pathForResource:@"chihuoyangshengSQLite3"
                              ofType:@"db"];
	BOOL copiedBackupDb = NO;
	if (backupDbPath != nil) {
		copiedBackupDb = [[NSFileManager defaultManager]
                          copyItemAtPath:backupDbPath
                          toPath:filePathName
                          error:nil];
	}
	
	// open SQLite db file
	self.db = [[ABSQLiteDB alloc] init];
	
	if(![self.db connect:filePathName]) {
		return nil;
	}
	
	if(!fileExists) {
		if(!backupDbPath || !copiedBackupDb)
			[self makeDB];
	}
	
	return self;
}

#pragma mark - 创建数据库对象
+ (MobileDB*) dbInstance {
	if (!_dbInstance) {
		NSString *dbFilePath;
		NSArray *searchPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentFolderPath = searchPaths[0];
		dbFilePath = [documentFolderPath stringByAppendingPathComponent: @"chihuoyangshengSQLite3.db"];
		
		MobileDB* mobileDB = [[MobileDB alloc] initWithFile:dbFilePath];
		if (!mobileDB) {
			NSLog(@"数据库打开失败！");
		}else{
            NSLog(@"数据库打开成功!");
        }
	}
	
	return _dbInstance;
}

#pragma mark- 关闭数据库
- (void) close {
	[self.db close];
    NSLog(@"数据库关闭成功");
}



#pragma mark - 数据库建表
- (void) makeDB {
	//建表
    //食材表
    [self.db sqlExecute:@"create table baseFood(alias text, b1 text,b2 text, b6 text, calcium text,carbohydrate text, cholesterol text, createTime text, dietaryFiber text, energy text, fat text, ferri text, folate text, foodName text, foodType text, foodTypeName text, glycemic text, _id text, introduce text, iodine text, nutrition text, nutritionTrait text, picture text, protein text, remark text, vitaminA text, vitaminC text, zinc text, primary key(_id));"];
    //字典表
    [self.db sqlExecute:@"create table dictionary(dictCode text, dictName text, _id text, nameJianpin text, namePinyin text, orderNo int, remark text, typeId text, primary key(_id));"];
    //省份表
    [self.db sqlExecute:@"create table province(_id text, jianpin text, name tex, primary key(_id));"];
    //城市表
    [self.db sqlExecute:@"create table city(_id text, jianpin text, name tex, provinceId text, primary key(_id));"];
}

#pragma mark- 从服务器获取食材数据
- (void)fetchAllBaseFoodFromServer
{
    //获取所有食材数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        BaseFoodBaseFoodServiceImplServiceSoapBinding *fooder = [[BaseFoodBaseFoodServiceImplServiceSoapBinding alloc] init];
        BaseFoodpageParam *pager = [[BaseFoodpageParam alloc] init];
        pager.page = 1;
        pager.rows = 0;
        BaseFoodjsonData *totalFood = [fooder findBaseFood:pager arg1:nil __error:nil];
        pager.rows = totalFood.total;

        NSString* sql = @"select count(*) totalBaseFood from baseFood;";
        id<ABRecordset> results = [self.db sqlSelect:sql];
        int totalBaseFood = 0;
        while (![results eof]) {
            totalBaseFood = [[results fieldWithName:@"totalBaseFood"] intValue];
            [results moveNext];
        }
        
        //if (totalBaseFood != totalFood.total) {
            NSLog(@"更新食材数据中......");
            BaseFoodjsonData *baseFoodJsonData = [fooder findBaseFood:pager arg1:nil __error:nil];
            for (BaseFoodbaseFood *food in baseFoodJsonData.rows){
                NSString *foodType = food.foodTypeName;
                if ([foodType isEqualToString:@"饮品"]) {
                    NSLog(@"%@:%@",food.foodName,food.introduce);
                }
                [self insertBaseFood:food];
                
            }
            NSLog(@"食材更新完毕！");
        //}
        
        
    });


    
   
}

#pragma mark - 插入一条食材记录
- (void)insertBaseFood:(BaseFoodbaseFood*)baseFood
{
    NSString* sql;
    BOOL exists = NO;
    sql = [NSString stringWithFormat:@"select * from baseFood where _id = '%@'",[self escapeText: baseFood.get_id] ];
    id<ABRecordset> results = [self.db sqlSelect:sql];
    if (![results eof]) {
        exists = YES;
    }
    if (exists) {
        sql = [NSString stringWithFormat:
               @"update baseFood set alias = '%@', b1 = '%@', b2 = '%@', b6 = '%@', calcium = '%@', carbohydrate = '%@', cholesterol = '%@', createTime = '%@', dietaryFiber = '%@', energy = '%@', fat = '%@', ferri = '%@', folate = '%@', foodName = '%@', foodType = '%@', foodTypeName = '%@', glycemic = '%@', _id = '%@', introduce = '%@', iodine = '%@', nutrition = '%@', nutritionTrait = '%@', picture = '%@', protein = '%@', remark = '%@', vitaminA = '%@', vitaminC = '%@', zinc = '%@';",
               [self escapeText:baseFood.alias],
               [self escapeText:baseFood.b1],
               [self escapeText:baseFood.b2],
               [self escapeText:baseFood.b6],
               [self escapeText:baseFood.calcium],
               [self escapeText:baseFood.carbohydrate],
               [self escapeText:baseFood.cholesterol],
               [self escapeText:[NSString stringWithFormat:@"%@",baseFood.createTime]],
               [self escapeText:baseFood.dietaryFiber],
               [self escapeText:baseFood.energy],
               [self escapeText:baseFood.fat],
               [self escapeText:baseFood.ferri],
               [self escapeText:baseFood.folate],
               [self escapeText:baseFood.foodName],
               [self escapeText:baseFood.foodType],
               [self escapeText:baseFood.foodTypeName],
               [self escapeText:baseFood.glycemic],
               [self escapeText:baseFood._id],
               [self escapeText:baseFood.introduce],
               [self escapeText:baseFood.iodine],
               [self escapeText:baseFood.nutrition],
               [self escapeText:baseFood.nutritionTrait],
               [self escapeText:baseFood.picture],
               [self escapeText:baseFood.protein],
               [self escapeText:baseFood.remark],
               [self escapeText:baseFood.vitaminA],
               [self escapeText:baseFood.vitaminC],
               [self escapeText:baseFood.zinc]];
    }else{
        sql = [NSString stringWithFormat:
               @"insert into baseFood(alias, b1, b2, b6, calcium, carbohydrate, cholesterol, createTime, dietaryFiber, energy, fat, ferri, folate, foodName, foodType, foodTypeName, glycemic, _id, introduce, iodine, nutrition, nutritionTrait, picture, protein, remark, vitaminA, vitaminC, zinc) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
               [self escapeText:baseFood.alias],
               [self escapeText:baseFood.b1],
               [self escapeText:baseFood.b2],
               [self escapeText:baseFood.b6],
               [self escapeText:baseFood.calcium],
               [self escapeText:baseFood.carbohydrate],
               [self escapeText:baseFood.cholesterol],
               [self escapeText:[NSString stringWithFormat:@"%@",baseFood.createTime]],
               [self escapeText:baseFood.dietaryFiber],
               [self escapeText:baseFood.energy],
               [self escapeText:baseFood.fat],
               [self escapeText:baseFood.ferri],
               [self escapeText:baseFood.folate],
               [self escapeText:baseFood.foodName],
               [self escapeText:baseFood.foodType],
               [self escapeText:baseFood.foodTypeName],
               [self escapeText:baseFood.glycemic],
               [self escapeText:baseFood._id],
               [self escapeText:baseFood.introduce],
               [self escapeText:baseFood.iodine],
               [self escapeText:baseFood.nutrition],
               [self escapeText:baseFood.nutritionTrait],
               [self escapeText:baseFood.picture],
               [self escapeText:baseFood.protein],
               [self escapeText:baseFood.remark],
               [self escapeText:baseFood.vitaminA],
               [self escapeText:baseFood.vitaminC],
               [self escapeText:baseFood.zinc]];
    }
    
    [self.db sqlExecute:sql];
}

#pragma mark- 从数据库获取食材block
- (void)allBaseFood:(CallBackWithDictionary)callBack
{
    NSMutableDictionary *allBaseFoodDictionary = [[NSMutableDictionary alloc] init];
    NSString* sql = @"select * from baseFood";
    id<ABRecordset> results = [self.db sqlSelect:sql];
    while (![results eof]) {
        BaseFoodbaseFood *food = [[BaseFoodbaseFood alloc] init];
        food.alias = [[results fieldWithName:@"alias"] stringValue];
        food.b1 = [[results fieldWithName:@"b1"] stringValue];
        food.b2 = [[results fieldWithName:@"b2"] stringValue];
        food.b6 = [[results fieldWithName:@"b6"] stringValue];
        food.calcium = [[results fieldWithName:@"calcium"] stringValue];
        food.carbohydrate = [[results fieldWithName:@"carbohydrate"] stringValue];
        food.cholesterol = [[results fieldWithName:@"cholesterol"] stringValue];
        food.createTime = [NSDate date];
        food.dietaryFiber = [[results fieldWithName:@"dietaryFiber"] stringValue];
        food.energy = [[results fieldWithName:@"energy"] stringValue];
        food.fat = [[results fieldWithName:@"fat"] stringValue];
        food.ferri = [[results fieldWithName:@"ferri"] stringValue];
        food.folate = [[results fieldWithName:@"folate"] stringValue];
        food.foodName = [[results fieldWithName:@"foodName"] stringValue];
        food.foodType = [[results fieldWithName:@"foodType"] stringValue];
        food.foodTypeName = [[results fieldWithName:@"foodTypeName"] stringValue];
        food.glycemic = [[results fieldWithName:@"glycemic"] stringValue];
        food._id = [[results fieldWithName:@"_id"] stringValue];
        food.introduce = [[results fieldWithName:@"introduce"] stringValue];
        food.iodine = [[results fieldWithName:@"iodine"] stringValue];
        food.nutrition = [[results fieldWithName:@"nutrition"] stringValue];
        food.nutritionTrait = [[results fieldWithName:@"nutritionTrait"] stringValue];
        food.picture = [[results fieldWithName:@"picture"] stringValue];
        food.protein = [[results fieldWithName:@"protein"] stringValue];
        food.remark = [[results fieldWithName:@"remark"] stringValue];
        food.vitaminA = [[results fieldWithName:@"vitaminA"] stringValue];
        food.vitaminC = [[results fieldWithName:@"vitaminC"] stringValue];
        food.zinc = [[results fieldWithName:@"zinc"] stringValue];
        
        NSString *foodTypeName = [[results fieldWithName:@"foodTypeName"] stringValue];
        if ([[allBaseFoodDictionary allKeys] containsObject:foodTypeName]) {
            NSMutableArray *array1 = allBaseFoodDictionary[foodTypeName];
            [array1 addObject:food];
        }else{
            if (foodTypeName) {
                NSMutableArray *array2 = [[NSMutableArray alloc] init];
                [array2 addObject:food];
                allBaseFoodDictionary[foodTypeName] = array2;
            }else{
                NSMutableArray *array3 = [[NSMutableArray alloc] init];
                [array3 addObject:food];
                allBaseFoodDictionary[@"other"] = array3;
            }
            
        }

        [results moveNext];
    }
    callBack(allBaseFoodDictionary);
}

#pragma mark- 从数据库获取食材 传统方法
- (NSMutableDictionary*)allBaseFood
{
    NSMutableDictionary *allBaseFoodDictionary = [[NSMutableDictionary alloc] init];
    NSString* sql = @"select * from baseFood";
    id<ABRecordset> results = [self.db sqlSelect:sql];
    while (![results eof]) {
        BaseFoodbaseFood *food = [[BaseFoodbaseFood alloc] init];
        food.alias = [[results fieldWithName:@"alias"] stringValue];
        food.b1 = [[results fieldWithName:@"b1"] stringValue];
        food.b2 = [[results fieldWithName:@"b2"] stringValue];
        food.b6 = [[results fieldWithName:@"b6"] stringValue];
        food.calcium = [[results fieldWithName:@"calcium"] stringValue];
        food.carbohydrate = [[results fieldWithName:@"carbohydrate"] stringValue];
        food.cholesterol = [[results fieldWithName:@"cholesterol"] stringValue];
        food.createTime = [NSDate date];
        food.dietaryFiber = [[results fieldWithName:@"dietaryFiber"] stringValue];
        food.energy = [[results fieldWithName:@"energy"] stringValue];
        food.fat = [[results fieldWithName:@"fat"] stringValue];
        food.ferri = [[results fieldWithName:@"ferri"] stringValue];
        food.folate = [[results fieldWithName:@"folate"] stringValue];
        food.foodName = [[results fieldWithName:@"foodName"] stringValue];
        food.foodType = [[results fieldWithName:@"foodType"] stringValue];
        food.foodTypeName = [[results fieldWithName:@"foodTypeName"] stringValue];
        food.glycemic = [[results fieldWithName:@"glycemic"] stringValue];
        food._id = [[results fieldWithName:@"_id"] stringValue];
        food.introduce = [[results fieldWithName:@"introduce"] stringValue];
        food.iodine = [[results fieldWithName:@"iodine"] stringValue];
        food.nutrition = [[results fieldWithName:@"nutrition"] stringValue];
        food.nutritionTrait = [[results fieldWithName:@"nutritionTrait"] stringValue];
        food.picture = [[results fieldWithName:@"picture"] stringValue];
        food.protein = [[results fieldWithName:@"protein"] stringValue];
        food.remark = [[results fieldWithName:@"remark"] stringValue];
        food.vitaminA = [[results fieldWithName:@"vitaminA"] stringValue];
        food.vitaminC = [[results fieldWithName:@"vitaminC"] stringValue];
        food.zinc = [[results fieldWithName:@"zinc"] stringValue];
        
        NSString *foodTypeName = [[results fieldWithName:@"foodTypeName"] stringValue];
        if ([[allBaseFoodDictionary allKeys] containsObject:foodTypeName]) {
            NSMutableArray *array1 = allBaseFoodDictionary[foodTypeName];
            [array1 addObject:food];
        }else{
            if (foodTypeName) {
                NSMutableArray *array2 = [[NSMutableArray alloc] init];
                [array2 addObject:food];
                allBaseFoodDictionary[foodTypeName] = array2;
            }else{
                NSMutableArray *array3 = [[NSMutableArray alloc] init];
                [array3 addObject:food];
                allBaseFoodDictionary[@"other"] = array3;
            }
            
        }
        
        [results moveNext];
    }
    return allBaseFoodDictionary;
}


#pragma mark- 从服务器获取所有字典数据
- (void)fetchAllDictionaryFromServer
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        AllDicsDictTypeServiceImplServiceSoapBinding *allDicsService =
        [[AllDicsDictTypeServiceImplServiceSoapBinding alloc] init];
        //获取所有字典数据
        DicDictServiceImplServiceSoapBinding *dicService = [[DicDictServiceImplServiceSoapBinding alloc] init];
        AllDicsgetAllDictTypeResponse *allDics = [allDicsService getAllDictType:nil];
        NSArray *dicsArray = allDics.items;
        
        NSLog(@"更新字典数据中......");
        for (AllDicsdictType *topDicItem in dicsArray){
            NSArray *subDicItems = [dicService getDictByTypeCode:topDicItem.typeCode __error:nil].items;
            for (Dicdict *subDicItem in subDicItems){
                [self insertDictionary:subDicItem];
            }
            
        }
        NSLog(@"字典更新完毕！");
    });
}

#pragma mark- 插入一条字典记录
- (void)insertDictionary:(Dicdict*)dicdict
{
    NSString* sql;
    BOOL exists = NO;
    sql = [NSString stringWithFormat:@"select * from dictionary where _id = '%@'",[self escapeText: dicdict.get_id] ];
    id<ABRecordset> results = [self.db sqlSelect:sql];
    if (![results eof]) {
        exists = YES;
    }
    if (exists) {
        sql = [NSString stringWithFormat:
               @"update dictionary set dictCode = '%@', dictName = '%@', _id = '%@', nameJianpin = '%@', namePinyin = '%@', orderNo = %d, remark = '%@', typeId = '%@';",
               [self escapeText:dicdict.dictCode],
               [self escapeText:dicdict.dictName],
               [self escapeText:dicdict._id],
               [self escapeText:dicdict.nameJianpin],
               [self escapeText:dicdict.namePinyin],
               dicdict.orderNo,
               [self escapeText:dicdict.remark],
               [self escapeText:dicdict.typeId]];
    }else{
        sql = [NSString stringWithFormat:
               @"insert into dictionary(dictCode, dictName, _id, nameJianpin, namePinyin, orderNo, remark, typeId) values ('%@','%@','%@','%@','%@',%d,'%@','%@')",
               [self escapeText:dicdict.dictCode],
               [self escapeText:dicdict.dictName],
               [self escapeText:dicdict._id],
               [self escapeText:dicdict.nameJianpin],
               [self escapeText:dicdict.namePinyin],
               dicdict.orderNo,
               [self escapeText:dicdict.remark],
               [self escapeText:dicdict.typeId]];
    }
    
    [self.db sqlExecute:sql];
}


#pragma mark- 从数据库获取所有字典数据
- (NSMutableDictionary*)allDictionaries
{
    NSMutableDictionary *allDictionaries = [[NSMutableDictionary alloc] init];
    NSString* sql = @"select * from dictionary";
    id<ABRecordset> results = [self.db sqlSelect:sql];
    while (![results eof]) {
        allDictionaries[[[results fieldWithName:@"dictName"] stringValue]]
        
        = @{@"dictCode": [[results fieldWithName:@"dictCode"] stringValue],
            @"dictName": [[results fieldWithName:@"dictName"] stringValue],
            @"_id": [[results fieldWithName:@"_id"] stringValue],
            @"typeId": [[results fieldWithName:@"typeId"] stringValue]};
        
        allDictionaries[[[results fieldWithName:@"_id"] stringValue]]
        
        = @{@"dictCode": [[results fieldWithName:@"dictCode"] stringValue],
            @"dictName": [[results fieldWithName:@"dictName"] stringValue],
            @"_id": [[results fieldWithName:@"_id"] stringValue],
            @"typeId": [[results fieldWithName:@"typeId"] stringValue]};


       
        
        [results moveNext];
    }
    return allDictionaries;

}


#pragma mark - 从服务器获取地区数据
- (void)fetchAllAreaFromServer
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        AreaAreaServiceImplServiceSoapBinding *areaBinding = [[AreaAreaServiceImplServiceSoapBinding alloc] init];
        AreagetAllProvinceResponse *provinceResponse = [areaBinding getAllProvince:nil];
        AreafindCityResponse *cityResponse =  [areaBinding findCity:nil arg1:nil arg2:nil __error:nil];
        
        NSLog(@"更新省份数据中......");
        for (Areaprovince *pro in provinceResponse.items){
            [self insertProvince:pro];
        }
        NSLog(@"省份更新完毕!");
        
        NSLog(@"更新城市数据中......");
        for (Areacity *city in cityResponse.items){
            [self insertCity:city];
        }
        NSLog(@"城市数据更新完毕!");
    });
    
}

#pragma mark - 插入一条省份数据
- (void)insertProvince:(Areaprovince*)province
{
    NSString* sql;
    BOOL exists = NO;
    sql = [NSString stringWithFormat:@"select * from province where _id = '%@'",[self escapeText: province.get_id] ];
    id<ABRecordset> results = [self.db sqlSelect:sql];
    if (![results eof]) {
        exists = YES;
    }
    if (exists) {
        sql = [NSString stringWithFormat:
               @"update province set jianpin = '%@', name = '%@' where  _id = '%@';",
               [self escapeText:province.jianpin],
               [self escapeText:province.name],
                [self escapeText:province._id]];
    }else{
        sql = [NSString stringWithFormat:
               @"insert into province(_id, jianpin, name) values ('%@','%@','%@')",
               [self escapeText:province._id],
               [self escapeText:province.jianpin],
               [self escapeText:province.name]];
    }
    
    [self.db sqlExecute:sql];

}

#pragma mark - 插入一条城市数据
- (void)insertCity:(Areacity*)city
{
    NSString* sql;
    BOOL exists = NO;
    sql = [NSString stringWithFormat:@"select * from city where _id = '%@'",[self escapeText: city.get_id] ];
    id<ABRecordset> results = [self.db sqlSelect:sql];
    if (![results eof]) {
        exists = YES;
    }
    if (exists) {
        sql = [NSString stringWithFormat:
               @"update city set jianpin = '%@', name = '%@', provinceId = '%@' where  _id = '%@';",
               [self escapeText:city.jianpin],
               [self escapeText:city.name],
               [self escapeText:city.provinceId],
               [self escapeText:city._id]];
    }else{
        sql = [NSString stringWithFormat:
               @"insert into city(_id, jianpin, name, provinceId) values ('%@','%@','%@','%@')",
               [self escapeText:city._id],
               [self escapeText:city.jianpin],
               [self escapeText:city.name],
               [self escapeText:city.provinceId]];
    }
    
    [self.db sqlExecute:sql];

}

#pragma mark- 从数据库获取所有省份数据
- (NSMutableArray*)allProvinces
{
    NSMutableArray *allProvinces = [[NSMutableArray alloc] init];
    NSString* sql = @"select * from province";
    id<ABRecordset> results = [self.db sqlSelect:sql];
    while (![results eof]) {
        Areaprovince *model = [[Areaprovince alloc] init];
        model._id = [[results fieldWithName:@"_id"] stringValue];
        model.jianpin = [[results fieldWithName:@"jianpin"] stringValue];
        model.name = [[results fieldWithName:@"name"] stringValue];
        [allProvinces addObject:model];
        [results moveNext];
    }
    return allProvinces;

}

#pragma mark- 从数据库获取所有城市数据
- (NSMutableArray*)allCities
{
    NSMutableArray *allCities = [[NSMutableArray alloc] init];
    NSString* sql = @"select * from city";
    id<ABRecordset> results = [self.db sqlSelect:sql];
    while (![results eof]) {
        Areacity *model = [[Areacity alloc] init];
        model._id = [[results fieldWithName:@"_id"] stringValue];
        model.jianpin = [[results fieldWithName:@"jianpin"] stringValue];
        model.name = [[results fieldWithName:@"name"] stringValue];
        model.provinceId = [[results fieldWithName:@"provinceId"] stringValue];
        [allCities addObject:model];
        [results moveNext];
    }
    return allCities;
    
}

#pragma mark- 工具方法
- (NSString *)uniqueID {
	CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
	NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
	CFRelease(uuid);
	
	return uuidString;
}

- (NSString*)escapeText:(NSString*)text {
	NSString* newValue = [text stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
	return newValue;
}


@end
