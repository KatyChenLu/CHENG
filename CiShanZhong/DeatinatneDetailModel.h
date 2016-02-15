//
//  DeatinatneDetailModel.h
//  CiShanZhong
//
//  Created by KatyChn on 16/1/3.
//  Copyright © 2016年 陈璐. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ContentsModel
@end

@protocol NoteModel
@end

@interface ContentsModel : JSONModel
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *description_html;
@end
//
@interface NoteModel : JSONModel
@property (nonatomic, copy)NSString *Ndescription;
@property (nonatomic, copy)NSString *photo_url;
@end

@interface DeatinatneDetailModel : JSONModel
@property (nonatomic, copy)NSString *Did;
@property (nonatomic, copy)NSString *name_zh_cn;
@property (nonatomic, copy)NSString *name_en;
@property (nonatomic, copy)NSString *poi_count;
@property (nonatomic, copy)NSString *plans_count;
@property (nonatomic, copy)NSString *articles_count;
@property (nonatomic, copy)NSString *contents_count;
@property (nonatomic, copy)NSString *destination_trips_count;
//@property (nonatomic, assign)BOOL locked;
//@property (nonatomic, assign)BOOL *wiki_app_publish;
@property (nonatomic, copy)NSString *updated_at;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *guides_count;
@property (nonatomic, strong)NSMutableArray <ContentsModel> *destination_contents;
@property (nonatomic, strong)NSMutableArray <NoteModel>*notesArray;
@end
