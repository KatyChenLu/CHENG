//
//  DetailModel.h
//  CiShanZhong
//
//  Created by KatyChn on 15/12/28.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import <JSONModel/JSONModel.h>


//@protocol NotesLikeCommentsModel
//@end
////@interface NotesLikeCommentsModel : JSONModel
//@end
@protocol TripDaysModel
@end
@protocol NodesModel
@end
@protocol NotesModel
@end

@interface NotesModel : JSONModel
@property (nonatomic, copy)NSString *Ddescription;
@property (nonatomic, copy)NSString *photoUrl;
@end

@interface NodesModel : JSONModel
//
@property (nonatomic, strong)NSMutableArray <NotesModel>*notes;
@end

@interface TripDaysModel : JSONModel
@property (nonatomic, copy)NSString *trip_date;
@property (nonatomic, copy)NSString *day;
@property (nonatomic, copy)NSString *destinationId;
@property (nonatomic, copy)NSString *destinationNameZhCn;
@property (nonatomic, strong)NSMutableArray <NodesModel>*nodes;
@end


@interface DetailModel : JSONModel
@property (nonatomic, copy)NSString *Did;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSMutableArray <TripDaysModel>*trip_days;
@property (nonatomic, copy)NSString *userID;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *userImage;
@property (nonatomic, copy)NSString *front_cover_photo_url;
//@property (nonatomic, strong)NSMutableArray <NotesLikeCommentsModel>*notesLikeCommentsModel;

@end
